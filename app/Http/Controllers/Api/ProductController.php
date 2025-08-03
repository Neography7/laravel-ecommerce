<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\ProductListRequest;
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
     * Sistemdeki ürünleri gelişmiş arama, filtreleme ve sayfalama özellikleri ile listeler.
     *
     * @tags Ürün Yönetimi
     * @operationId getProducts
     * @summary Ürün listesi (Gelişmiş Arama ve Filtreleme)
     * @description Bu endpoint ile sistemdeki ürünleri arama, filtreleme ve sayfalama özellikleri ile listeleyebilirsiniz.
     *
     * @queryParam search string Ürün adında veya açıklamasında arama yapar (min: 2 karakter)
     * @queryParam category_id integer Belirli kategorideki ürünleri filtreler
     * @queryParam min_price decimal Minimum fiyat filtresi
     * @queryParam max_price decimal Maksimum fiyat filtresi (min_price'dan büyük olmalı)
     * @queryParam in_stock boolean Sadece stokta olan ürünleri gösterir (1 veya true)
     * @queryParam sort_by string Sıralama alanı (name, price, created_at, stock_quantity). Varsayılan: name
     * @queryParam sort_order string Sıralama yönü (asc, desc). Varsayılan: asc
     * @queryParam per_page integer Sayfa başına ürün sayısı (1-50 arası). Varsayılan: 15
     * @queryParam page integer Sayfa numarası. Varsayılan: 1
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Ürünler başarıyla listelendi",
     *   "data": {
     *     "products": [
     *       {
     *         "id": 1,
     *         "name": "iPhone 15",
     *         "description": "Latest iPhone model",
     *         "price": "999.99",
     *         "stock_quantity": 50,
     *         "category": {
     *           "id": 1,
     *           "name": "Electronics"
     *         }
     *       }
     *     ],
     *     "pagination": {
     *       "current_page": 1,
     *       "per_page": 15,
     *       "total": 1,
     *       "last_page": 1,
     *       "from": 1,
     *       "to": 1,
     *       "has_more_pages": false
     *     },
     *     "filters": {
     *       "search": "iPhone",
     *       "category_id": 1,
     *       "min_price": 500,
     *       "max_price": 2000,
     *       "in_stock": true,
     *       "sort_by": "name",
     *       "sort_order": "asc"
     *     }
     *   },
     *   "errors": null
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "search": ["Arama terimi en az 2 karakter olmalıdır."],
     *     "max_price": ["Maksimum fiyat minimum fiyattan küçük olamaz."]
     *   }
     * }
     */
    public function index(ProductListRequest $request): JsonResponse
    {
        $validated = $request->validated();
        $perPage = $validated['per_page'] ?? 15;

        $query = Product::with('category');

        // Arama
        if (!empty($validated['search'])) {
            $query->search($validated['search']);
        }

        // Kategori filtresi
        if (!empty($validated['category_id'])) {
            $query->byCategory($validated['category_id']);
        }

        // Fiyat aralığı
        if (isset($validated['min_price']) || isset($validated['max_price'])) {
            $query->priceRange($validated['min_price'] ?? null, $validated['max_price'] ?? null);
        }

        // Stok filtresi
        if (!empty($validated['in_stock'])) {
            $query->inStock();
        }

        // Sıralama
        $sortBy = $validated['sort_by'] ?? 'name';
        $sortOrder = $validated['sort_order'] ?? 'asc';
        $query->sortBy($sortBy, $sortOrder);

        $products = $query->paginate($perPage);

        return apiSuccess([
            'products' => ProductResource::collection($products->items()),
            'pagination' => [
                'current_page' => $products->currentPage(),
                'per_page' => $products->perPage(),
                'total' => $products->total(),
                'last_page' => $products->lastPage(),
                'from' => $products->firstItem(),
                'to' => $products->lastItem(),
                'has_more_pages' => $products->hasMorePages(),
            ],
            'filters' => array_filter([
                'search' => $validated['search'] ?? null,
                'category_id' => isset($validated['category_id']) ? (int)$validated['category_id'] : null,
                'min_price' => isset($validated['min_price']) ? (float)$validated['min_price'] : null,
                'max_price' => isset($validated['max_price']) ? (float)$validated['max_price'] : null,
                'in_stock' => isset($validated['in_stock']) ? (bool)$validated['in_stock'] : null,
                'sort_by' => $sortBy,
                'sort_order' => $sortOrder,
            ], function ($value) {
                return $value !== null;
            })
        ], 'Ürünler başarıyla listelendi');
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
