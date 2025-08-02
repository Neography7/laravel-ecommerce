<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\StoreCategoryRequest;
use App\Http\Requests\Api\UpdateCategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Category;
use Illuminate\Http\JsonResponse;

class CategoryController extends Controller
{
    /**
     * Kategori Listesi
     *
     * Tüm kategorileri listeler.
     *
     * @tags Kategori Yönetimi
     * @operationId getCategories
     * @summary Kategori listesi
     * @description Sistemdeki tüm kategorileri listeler. Bu endpoint herkese açıktır.
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Kategoriler başarıyla listelendi",
     *   "data": [
     *     {
     *       "id": 1,
     *       "name": "Elektronik",
     *       "description": "Elektronik ürünler kategorisi",
     *       "products_count": 10,
     *       "created_at": "2025-08-02T15:44:17.000000Z",
     *       "updated_at": "2025-08-02T15:44:17.000000Z"
     *     }
     *   ]
     * }
     */
    public function index(): JsonResponse
    {
        $categories = Category::all();

        return apiSuccess(
            CategoryResource::collection($categories),
            'Kategoriler başarıyla listelendi'
        );
    }

    /**
     * Kategori Oluşturma
     *
     * Yeni bir kategori oluşturur.
     *
     * @tags Kategori Yönetimi
     * @operationId createCategory
     * @summary Yeni kategori oluştur
     * @description Bu endpoint ile yeni bir kategori oluşturabilirsiniz. Admin yetkisi gereklidir.
     *
     * @response 201 {
     *   "success": true,
     *   "message": "Kategori başarıyla oluşturuldu",
     *   "data": {
     *     "id": 1,
     *     "name": "Elektronik",
     *     "description": "Elektronik ürünler kategorisi",
     *     "products_count": 0,
     *     "created_at": "2025-08-02T15:44:17.000000Z",
     *     "updated_at": "2025-08-02T15:44:17.000000Z"
     *   }
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "name": ["Kategori adı zorunludur."]
     *   }
     * }
     *
     * @response 403 {
     *   "success": false,
     *   "message": "Bu işlem için admin yetkisi gerekli.",
     *   "errors": {
     *     "permission": ["Admin yetkisi gerekli."]
     *   }
     * }
     */
    public function store(StoreCategoryRequest $request): JsonResponse
    {
        $category = Category::create($request->validated());

        return apiSuccess(
            new CategoryResource($category),
            'Kategori başarıyla oluşturuldu',
            201
        );
    }

    /**
     * Kategori Detayı
     *
     * Belirli bir kategorinin detayını gösterir.
     *
     * @tags Kategori Yönetimi
     * @operationId getCategoryById
     * @summary Kategori detayı
     * @description Belirtilen ID'ye sahip kategorinin detaylarını getirir.
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Kategori başarıyla getirildi",
     *   "data": {
     *     "id": 1,
     *     "name": "Elektronik",
     *     "description": "Elektronik ürünler kategorisi",
     *     "products_count": 10,
     *     "created_at": "2025-08-02T15:44:17.000000Z",
     *     "updated_at": "2025-08-02T15:44:17.000000Z"
     *   }
     * }
     *
     * @response 404 {
     *   "success": false,
     *   "message": "Kategori bulunamadı",
     *   "errors": {
     *     "category": ["Belirtilen kategori bulunamadı."]
     *   }
     * }
     */
    public function show(Category $category): JsonResponse
    {
        return apiSuccess(
            new CategoryResource($category),
            'Kategori başarıyla getirildi'
        );
    }

    /**
     * Kategori Güncelleme
     *
     * Mevcut bir kategoriyi günceller.
     *
     * @tags Kategori Yönetimi
     * @operationId updateCategory
     * @summary Kategori güncelle
     * @description Bu endpoint ile mevcut bir kategoriyi güncelleyebilirsiniz. Admin yetkisi gereklidir.
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Kategori başarıyla güncellendi",
     *   "data": {
     *     "id": 1,
     *     "name": "Elektronik",
     *     "description": "Güncellenmiş açıklama",
     *     "products_count": 10,
     *     "created_at": "2025-08-02T15:44:17.000000Z",
     *     "updated_at": "2025-08-02T15:50:00.000000Z"
     *   }
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "name": ["Bu kategori adı zaten kullanılıyor."]
     *   }
     * }
     *
     * @response 404 {
     *   "success": false,
     *   "message": "Kategori bulunamadı",
     *   "errors": {
     *     "category": ["Belirtilen kategori bulunamadı."]
     *   }
     * }
     *
     * @response 403 {
     *   "success": false,
     *   "message": "Bu işlem için admin yetkisi gerekli.",
     *   "errors": {
     *     "permission": ["Admin yetkisi gerekli."]
     *   }
     * }
     */
    public function update(UpdateCategoryRequest $request, Category $category): JsonResponse
    {
        $category->update($request->validated());

        return apiSuccess(
            new CategoryResource($category),
            'Kategori başarıyla güncellendi'
        );
    }

    /**
     * Kategori Silme
     *
     * Mevcut bir kategoriyi siler.
     *
     * @tags Kategori Yönetimi
     * @operationId deleteCategory
     * @summary Kategori sil
     * @description Bu endpoint ile mevcut bir kategoriyi silebilirsiniz. Admin yetkisi gereklidir.
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Kategori başarıyla silindi",
     *   "data": null
     * }
     *
     * @response 404 {
     *   "success": false,
     *   "message": "Kategori bulunamadı",
     *   "errors": {
     *     "category": ["Belirtilen kategori bulunamadı."]
     *   }
     * }
     *
     * @response 403 {
     *   "success": false,
     *   "message": "Bu işlem için admin yetkisi gerekli.",
     *   "errors": {
     *     "permission": ["Admin yetkisi gerekli."]
     *   }
     * }
     *
     * @response 409 {
     *   "success": false,
     *   "message": "Bu kategori silinemez",
     *   "errors": {
     *     "category": ["Bu kategoriye ait ürünler bulunduğu için silinemez."]
     *   }
     * }
     */
    public function destroy(Category $category): JsonResponse
    {
        $category->delete();

        return apiSuccess(
            null,
            'Kategori başarıyla silindi'
        );
    }
}
