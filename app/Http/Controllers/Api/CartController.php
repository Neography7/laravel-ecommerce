<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\AddToCartRequest;
use App\Http\Requests\Api\UpdateCartRequest;
use App\Http\Resources\CartResource;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Product;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    /**
     * Sepeti Görüntüle
     *
     * Kullanıcının sepetini ve içindeki ürünleri getirir.
     *
     * @tags Sepet Yönetimi
     * @operationId getCart
     * @summary Sepeti görüntüle
     * @description Bu endpoint ile kullanıcının sepetini görüntüleyebilirsiniz.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Sepet başarıyla getirildi",
     *   "data": {
     *     "id": 1,
     *     "user_id": 1,
     *     "items": [],
     *     "total": "0.00",
     *     "total_items": 0,
     *     "created_at": "2025-08-02T10:00:00.000000Z",
     *     "updated_at": "2025-08-02T10:00:00.000000Z"
     *   }
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function index(): JsonResponse
    {
        $user = Auth::user();

        // Kullanıcının sepeti yoksa oluştur
        $cart = $user->cart ?? $user->cart()->create();

        $cart->load(['items.product.category']);

        return apiSuccess(new CartResource($cart), 'Sepet başarıyla getirildi');
    }

    /**
     * Sepete Ürün Ekle
     *
     * Sepete yeni ürün ekler veya mevcut ürünün miktarını artırır.
     *
     * @tags Sepet Yönetimi
     * @operationId addToCart
     * @summary Sepete ürün ekle
     * @description Bu endpoint ile sepete ürün ekleyebilirsiniz.
     * @authenticated
     * @security Bearer
     *
     * @response 201 {
     *   "success": true,
     *   "message": "Ürün sepete eklendi",
     *   "data": null
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "product_id": ["Ürün bulunamadı."],
     *     "quantity": ["Miktar en az 1 olmalıdır."]
     *   }
     * }
     *
     * @response 400 {
     *   "success": false,
     *   "message": "Yetersiz stok. Mevcut stok: 5",
     *   "data": null
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function add(AddToCartRequest $request): JsonResponse
    {
        $user = Auth::user();
        $product = Product::find($request->product_id);

        // Stok kontrolü
        if ($product->stock_quantity < $request->quantity) {
            return apiError("Yetersiz stok. Mevcut stok: {$product->stock_quantity}", [], 400);
        }

        // Kullanıcının sepeti yoksa oluştur
        $cart = $user->cart;
        if (!$cart) {
            $cart = $user->cart()->create();
            $user->refresh(); // Relationship'i refresh et
        }

        // Sepette bu ürün var mı kontrol et
        $cartItem = $cart->items()->where('product_id', $request->product_id)->first();

        if ($cartItem) {
            // Ürün zaten sepette, miktarını artır
            $newQuantity = $cartItem->quantity + $request->quantity;

            // Toplam miktar stok kontrolü
            if ($product->stock_quantity < $newQuantity) {
                return apiError("Yetersiz stok. Mevcut stok: {$product->stock_quantity}, sepetteki miktar: {$cartItem->quantity}", [], 400);
            }

            $cartItem->update(['quantity' => $newQuantity]);
            $message = 'Ürün miktarı artırıldı';
        } else {
            // Yeni ürün ekle
            $cart->items()->create([
                'product_id' => $request->product_id,
                'quantity' => $request->quantity,
            ]);
            $message = 'Ürün sepete eklendi';
        }

        return apiSuccess(null, $message, 201);
    }

    /**
     * Sepet Ürün Miktarı Güncelle
     *
     * Sepetteki ürünün miktarını günceller.
     *
     * @tags Sepet Yönetimi
     * @operationId updateCartItem
     * @summary Sepet ürün miktarı güncelle
     * @description Bu endpoint ile sepetteki ürünün miktarını güncelleyebilirsiniz.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Sepet güncellendi",
     *   "data": null
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "product_id": ["Ürün bulunamadı."],
     *     "quantity": ["Miktar en az 1 olmalıdır."]
     *   }
     * }
     *
     * @response 404 {
     *   "success": false,
     *   "message": "Ürün sepette bulunamadı",
     *   "data": null
     * }
     *
     * @response 400 {
     *   "success": false,
     *   "message": "Yetersiz stok. Mevcut stok: 5",
     *   "data": null
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function update(UpdateCartRequest $request): JsonResponse
    {
        $user = Auth::user();
        $cart = $user->cart;

        if (!$cart) {
            return apiError('Sepet bulunamadı', [], 404);
        }

        $cartItem = $cart->items()->where('product_id', $request->product_id)->first();

        if (!$cartItem) {
            return apiError('Ürün sepette bulunamadı', [], 404);
        }

        $product = $cartItem->product;

        // Stok kontrolü
        if ($product->stock_quantity < $request->quantity) {
            return apiError("Yetersiz stok. Mevcut stok: {$product->stock_quantity}", [], 400);
        }

        $cartItem->update(['quantity' => $request->quantity]);

        return apiSuccess(null, 'Sepet güncellendi');
    }

    /**
     * Sepetten Ürün Çıkar
     *
     * Belirtilen ürünü sepetten çıkarır.
     *
     * @tags Sepet Yönetimi
     * @operationId removeFromCart
     * @summary Sepetten ürün çıkar
     * @description Bu endpoint ile sepetten ürün çıkarabilirsiniz.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Ürün sepetten çıkarıldı",
     *   "data": null
     * }
     *
     * @response 404 {
     *   "success": false,
     *   "message": "Ürün sepette bulunamadı",
     *   "data": null
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function remove(Product $product): JsonResponse
    {
        $user = Auth::user();
        $cart = $user->cart;

        if (!$cart) {
            return apiError('Sepet bulunamadı', [], 404);
        }

        $cartItem = $cart->items()->where('product_id', $product->id)->first();

        if (!$cartItem) {
            return apiError('Ürün sepette bulunamadı', [], 404);
        }

        $cartItem->delete();

        return apiSuccess(null, 'Ürün sepetten çıkarıldı');
    }

    /**
     * Sepeti Temizle
     *
     * Sepetteki tüm ürünleri temizler.
     *
     * @tags Sepet Yönetimi
     * @operationId clearCart
     * @summary Sepeti temizle
     * @description Bu endpoint ile sepeti tamamen temizleyebilirsiniz.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Sepet temizlendi",
     *   "data": null
     * }
     *
     * @response 404 {
     *   "success": false,
     *   "message": "Sepet bulunamadı",
     *   "data": null
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function clear(): JsonResponse
    {
        $user = Auth::user();
        $cart = $user->cart;

        if (!$cart) {
            return apiError('Sepet bulunamadı', [], 404);
        }

        $cart->items()->delete();

        return apiSuccess(null, 'Sepet temizlendi');
    }
}
