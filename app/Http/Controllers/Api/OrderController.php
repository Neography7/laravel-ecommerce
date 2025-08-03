<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\OrderResource;
use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderItem;
use App\Events\OrderCreated;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class OrderController extends Controller
{
    /**
     * Siparişleri Listele
     *
     * Kullanıcının tüm siparişlerini getirir.
     *
     * @tags Sipariş Yönetimi
     * @operationId getOrders
     * @summary Siparişleri listele
     * @description Bu endpoint ile kullanıcının tüm siparişlerini listeleyebilirsiniz.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "data": [
     *     {
     *       "id": 1,
     *       "user_id": 1,
     *       "total_amount": "150.00",
     *       "status": "pending",
     *       "total_items": 3,
     *       "order_items": [],
     *       "created_at": "2025-08-02T10:00:00",
     *       "updated_at": "2025-08-02T10:00:00"
     *     }
     *   ],
     *   "links": {},
     *   "meta": {}
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function index(): AnonymousResourceCollection
    {
        $this->authorize('viewAny', Order::class);

        $orders = Auth::guard('sanctum')->user()->orders()
            ->with(['orderItems.product'])
            ->latest()
            ->paginate(10);

        return OrderResource::collection($orders);
    }

    /**
     * Sipariş Oluştur
     *
     * Kullanıcının sepetindeki ürünlerden yeni bir sipariş oluşturur.
     *
     * @tags Sipariş Yönetimi
     * @operationId createOrder
     * @summary Sipariş oluştur
     * @description Bu endpoint ile kullanıcının sepetindeki ürünlerden yeni bir sipariş oluşturabilirsiniz. Sipariş oluştuktan sonra sepet temizlenir ve ürün stokları güncellenir.
     * @authenticated
     * @security Bearer
     *
     * @response 201 {
     *   "data": {
     *     "id": 1,
     *     "user_id": 1,
     *     "total_amount": "200.00",
     *     "status": "pending",
     *     "total_items": 2,
     *     "order_items": [
     *       {
     *         "id": 1,
     *         "order_id": 1,
     *         "product_id": 1,
     *         "quantity": 2,
     *         "price": "100.00",
     *         "subtotal": "200.00",
     *         "product": {}
     *       }
     *     ],
     *     "created_at": "2025-08-02T10:00:00",
     *     "updated_at": "2025-08-02T10:00:00"
     *   }
     * }
     *
     * @response 400 {
     *   "message": "Sepetinizde ürün bulunmuyor."
     * }
     *
     * @response 400 {
     *   "message": "Sipariş oluşturulurken bir hata oluştu: Ürün için yeterli stok yok."
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function store(): OrderResource|JsonResponse
    {
        $this->authorize('create', Order::class);

        $user = Auth::guard('sanctum')->user();
        $cart = Cart::with('items.product')->where('user_id', $user->id)->first();

        if (!$cart || $cart->items->isEmpty()) {
            return apiError('Sepetinizde ürün bulunmuyor.', [], 400);
        }

        DB::beginTransaction();

        try {
            // Siparişi oluştur
            $order = Order::create([
                'user_id' => $user->id,
                'total_amount' => $cart->total,
                'status' => 'pending',
            ]);

            // Sipariş kalemlerini oluştur ve stok azalt
            foreach ($cart->items as $cartItem) {
                $product = $cartItem->product;

                // Stok durumunu kontrol et
                if ($product->stock_quantity < $cartItem->quantity) {
                    throw new \Exception("Ürün '{$product->name}' için yeterli stok yok.");
                }

                // Sipariş kalemi oluştur
                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'quantity' => $cartItem->quantity,
                    'price' => $product->price, // Sipariş anındaki güncel fiyatı kullan
                ]);
            }

            // Sepeti temizle
            $cart->items()->delete();
            $cart->delete();

            DB::commit();

            // Event dispatch - Email gönderimi için
            OrderCreated::dispatch($order);

            return new OrderResource($order->load(['orderItems.product']));
        } catch (\Exception $e) {
            DB::rollBack();

            return apiError(
                'Sipariş oluşturulurken bir hata oluştu: ' . $e->getMessage(),
                [],
                400
            );
        }
    }

    /**
     * Sipariş Detayı
     *
     * Belirtilen siparişin detaylarını getirir.
     *
     * @tags Sipariş Yönetimi
     * @operationId getOrder
     * @summary Sipariş detayını görüntüle
     * @description Bu endpoint ile belirli bir siparişin detaylarını görüntüleyebilirsiniz. Sadece kendi siparişlerinizi görüntüleyebilirsiniz.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "data": {
     *     "id": 1,
     *     "user_id": 1,
     *     "total_amount": "200.00",
     *     "status": "pending",
     *     "total_items": 2,
     *     "order_items": [
     *       {
     *         "id": 1,
     *         "order_id": 1,
     *         "product_id": 1,
     *         "quantity": 2,
     *         "price": "100.00",
     *         "subtotal": "200.00",
     *         "product": {
     *           "id": 1,
     *           "name": "Ürün Adı",
     *           "price": "100.00"
     *         }
     *       }
     *     ],
     *     "created_at": "2025-08-02T10:00:00",
     *     "updated_at": "2025-08-02T10:00:00"
     *   }
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     *
     * @response 404 {
     *   "message": "Sipariş bulunamadı."
     * }
     */
    public function show(Order $order): OrderResource
    {
        $this->authorize('view', $order);

        $order->load(['orderItems.product']);

        return new OrderResource($order);
    }
}
