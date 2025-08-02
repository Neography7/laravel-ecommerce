<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\StoreProductRequest;
use App\Http\Requests\Api\UpdateProductRequest;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use Illuminate\Http\JsonResponse;

class ProductController extends Controller
{
    /**
     * Ürün Listesi
     *
     * Sistemdeki tüm ürünleri listeler. Misafir kullanıcılar da erişebilir.
     *
     * @tags Ürün Yönetimi
     * @operationId getProducts
     * @summary Ürün listesi
     * @description Bu endpoint ile sistemdeki tüm ürünleri listeleyebilirsiniz. Ürünler kategori bilgileri ile birlikte döner.
     */
    public function index(): JsonResponse
    {
        $products = Product::with('category')->get();

        return apiSuccess(ProductResource::collection($products), 'Ürünler başarıyla listelendi');
    }

    /**
     * Ürün Oluşturma
     *
     * Yeni bir ürün kaydı oluşturur. Sadece admin kullanıcılar erişebilir.
     *
     * @tags Ürün Yönetimi
     * @operationId createProduct
     * @summary Yeni ürün oluştur
     * @description Bu endpoint ile yeni bir ürün kaydı oluşturabilirsiniz. Admin yetkisi gereklidir.
     * @authenticated
     * @security Bearer
     *
     * @response 201 {
     *   "success": true,
     *   "message": "Ürün başarıyla oluşturuldu",
     *   "data": {
     *     "id": 1,
     *     "name": "iPhone 15",
     *     "description": "Latest iPhone model",
     *     "price": "999.99",
     *     "stock_quantity": 50,
     *     "category_id": 1,
     *     "category": {
     *       "id": 1,
     *       "name": "Electronics",
     *       "description": "Electronic devices"
     *     },
     *     "created_at": "2025-08-02T10:00:00.000000Z",
     *     "updated_at": "2025-08-02T10:00:00.000000Z"
     *   },
     *   "errors": null
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "name": ["Ürün adı gereklidir."],
     *     "price": ["Fiyat gereklidir."]
     *   }
     * }
     *
     * @response 403 {
     *   "success": false,
     *   "message": "Bu işlem için admin yetkisi gerekli.",
     *   "data": null,
     *   "errors": null
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function store(StoreProductRequest $request): JsonResponse
    {
        $product = Product::create($request->validated());
        $product->load('category');

        return apiSuccess(new ProductResource($product), 'Ürün başarıyla oluşturuldu', 201);
    }

    /**
     * Ürün Detayı
     *
     * Belirtilen ürünün detaylarını getirir. Misafir kullanıcılar da erişebilir.
     *
     * @tags Ürün Yönetimi
     * @operationId getProduct
     * @summary Ürün detayı
     * @description Bu endpoint ile belirtilen ürünün detaylarını görüntüleyebilirsiniz.
     */
    public function show(Product $product): JsonResponse
    {
        $product->load('category');

        return apiSuccess(new ProductResource($product), 'Ürün başarıyla getirildi');
    }

    /**
     * Ürün Güncelleme
     *
     * Mevcut bir ürünü günceller. Sadece admin kullanıcılar erişebilir.
     *
     * @tags Ürün Yönetimi
     * @operationId updateProduct
     * @summary Ürün güncelle
     * @description Bu endpoint ile mevcut bir ürünü güncelleyebilirsiniz. Admin yetkisi gereklidir.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Ürün başarıyla güncellendi",
     *   "data": {
     *     "id": 1,
     *     "name": "iPhone 15 Pro",
     *     "description": "Updated iPhone model",
     *     "price": "1099.99",
     *     "stock_quantity": 30,
     *     "category_id": 1,
     *     "category": {
     *       "id": 1,
     *       "name": "Electronics",
     *       "description": "Electronic devices"
     *     },
     *     "created_at": "2025-08-02T10:00:00.000000Z",
     *     "updated_at": "2025-08-02T11:00:00.000000Z"
     *   },
     *   "errors": null
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "name": ["Bu ürün adı zaten kullanılıyor."]
     *   }
     * }
     *
     * @response 403 {
     *   "success": false,
     *   "message": "Bu işlem için admin yetkisi gerekli.",
     *   "data": null,
     *   "errors": null
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function update(UpdateProductRequest $request, Product $product): JsonResponse
    {
        $product->update($request->validated());
        $product->load('category');

        return apiSuccess(new ProductResource($product), 'Ürün başarıyla güncellendi');
    }

    /**
     * Ürün Silme
     *
     * Mevcut bir ürünü siler. Sadece admin kullanıcılar erişebilir.
     *
     * @tags Ürün Yönetimi
     * @operationId destroyProduct
     * @summary Ürün sil
     * @description Bu endpoint ile mevcut bir ürünü silebilirsiniz. Admin yetkisi gereklidir.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Ürün başarıyla silindi",
     *   "data": null,
     *   "errors": null
     * }
     *
     * @response 404 {
     *   "message": "Not Found."
     * }
     *
     * @response 403 {
     *   "success": false,
     *   "message": "Bu işlem için admin yetkisi gerekli.",
     *   "data": null,
     *   "errors": null
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function destroy(Product $product): JsonResponse
    {
        $product->delete();

        return apiSuccess(null, 'Ürün başarıyla silindi');
    }
}
