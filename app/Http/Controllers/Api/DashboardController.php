<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Concurrency;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    /**
     * Dashboard İstatistikleri
     *
     * Admin dashboard için temel istatistikleri getirir. Laravel 12 Concurrency kullanarak
     * birden fazla veriyi paralel olarak çeker ve performanslı bir dashboard sağlar.
     *
     * @tags Admin Dashboard
     * @operationId getDashboardStats
     * @summary Dashboard istatistiklerini getir
     * @description Bu endpoint ile admin dashboard için gerekli temel istatistikleri görüntüleyebilirsiniz. Laravel 12 Concurrency ile paralel veri çekme.
     * @authenticated
     * @security Bearer
     *
     * @response 200 {
     *   "data": {
     *     "summary": {
     *       "total_orders": 150,
     *       "total_revenue": "15000.00",
     *       "total_users": 85,
     *       "total_products": 45
     *     },
     *     "recent_orders": [
     *       {
     *         "id": 1,
     *         "user": {
     *           "name": "John Doe",
     *           "email": "john@example.com"
     *         },
     *         "total_amount": "250.00",
     *         "status": "pending",
     *         "created_at": "2025-08-02T10:00:00"
     *       }
     *     ],
     *     "top_products": [
     *       {
     *         "name": "Ürün Adı",
     *         "total_sold": 45
     *       }
     *     ],
     *     "orders_by_status": [
     *       {
     *         "status": "pending",
     *         "count": 12
     *       }
     *     ]
     *   }
     * }
     *
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     *
     * @response 403 {
     *   "message": "Bu işlem için admin yetkisi gereklidir."
     * }
     */
    public function index(): JsonResponse
    {

        [
            $totalOrders,
            $totalRevenue,
            $totalUsers,
            $totalProducts,
            $recentOrders,
            $topProducts,
            $ordersByStatus
        ] = Concurrency::run([
            // Temel istatistikler
            fn() => Order::count(),
            fn() => Order::sum('total_amount'),
            fn() => User::whereDoesntHave('roles', function ($query) {
                $query->where('name', 'admin');
            })->count(),
            fn() => Product::count(),

            // Son 5 sipariş
            fn() => Order::with(['user:id,name,email'])
                ->latest()
                ->limit(5)
                ->get(['id', 'user_id', 'total_amount', 'status', 'created_at']),

            // En çok satılan 5 ürün - Eloquent ile
            fn() => Product::topSelling(5)->get()->map(function ($product) {
                return [
                    'id' => $product->id,
                    'name' => $product->name,
                    'total_sold' => $product->total_sold
                ];
            }),

            // Sipariş durumlarına göre dağılım
            fn() => Order::select('status', DB::raw('count(*) as count'))
                ->groupBy('status')
                ->get()
        ]);

        return apiSuccess([
            'summary' => [
                'total_orders' => $totalOrders,
                'total_revenue' => $totalRevenue,
                'total_users' => $totalUsers,
                'total_products' => $totalProducts,
            ],
            'recent_orders' => $recentOrders,
            'top_products' => $topProducts,
            'orders_by_status' => $ordersByStatus,
        ], 'Dashboard istatistikleri başarıyla getirildi');
    }
}
