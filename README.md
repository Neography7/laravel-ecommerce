# Laravel E-Commerce Projesi

<p align="center">
<a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="300" alt="Laravel Logo"></a>
</p>

<p align="center">
<img src="https://img.shields.io/badge/Laravel-12.x-red.svg" alt="Laravel Version">
<img src="https://img.shields.io/badge/PHP-8.2+-blue.svg" alt="PHP Version">
<img src="https://img.shields.io/badge/PostgreSQL-15-blue.svg" alt="PostgreSQL Version">
<img src="https://img.shields.io/badge/Docker-Ready-green.svg" alt="Docker Ready">
<img src="https://img.shields.io/badge/Code%20Coverage-91%25-brightgreen.svg" alt="Code Coverage">
<img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License">
</p>

Laravel 12 ile geliştirilen bu proje, modern bir e-ticaret uygulaması oluşturmak için Laravel framework'ünün en son özelliklerini kullanır. Event-driven mimari, model observers, queue system, concurrency özellikleri, custom policies ve background job processing gibi Laravel'in gelişmiş imkanlarını etkin bir şekilde kullanarak enterprise seviyede bir uygulama geliştirme örneği sunar.

## 🚀 Teknolojiler & Özellikler

### Backend Teknolojileri
- **PHP 8.2+** - Modern PHP özellikleri ile
- **Laravel 12.x** - En güncel Laravel framework
- **PostgreSQL 15** - Güçlü ve güvenilir veritabanı
- **Laravel Sanctum** - API token authentication
- **Laravel Telescope** - Debugging ve monitoring
- **Spatie Laravel Permission** - Rol ve yetki yönetimi
- **Scramble** - Otomatik API dokümantasyonu

### Laravel Gelişmiş Özellikleri
- **Events & Listeners** - Asynchronous event handling (OrderCreated)
- **Model Observers** - Otomatik model lifecycle yönetimi (OrderItemObserver)
- **Queue System** - Background job processing ile e-posta gönderimi
- **Concurrency** - Laravel 12'nin yeni eşzamanlılık özellikleri
- **Custom Helpers** - Özel yardımcı fonksiyonlar
- **Policy Authorization** - Granular yetkilendirme kontrolü

### DevOps & Konteynerleştirme
- **Docker & Docker Compose** - Konteynerleştirme
- **Nginx Alpine** - Web server
- **PHP-FPM** - PHP process manager

### Test & Code Quality
- **Pest PHP** - Modern testing framework
- **Laravel Pint** - Code formatting  
- **PHPUnit** - Unit testing
- **Code Coverage** - %91+ test coverage ile güvenilir kod kalitesi

## 📋 Proje Yapısı

### Veritabanı Modelleri
- **User** - Kullanıcı yönetimi
- **Category** - Ürün kategorileri
- **Product** - Ürün katalogu
- **Cart** - Alışveriş sepeti
- **CartItem** - Sepet öğeleri
- **Order** - Siparişler
- **OrderItem** - Sipariş detayları

### API Özellikleri
- RESTful API mimarisi
- Sanctum ile token authentication
- Rol ve yetki tabanlı erişim kontrolü
- Otomatik API dokümantasyonu (Scramble)
- Request validation ve response formatting

### Laravel Mimarisi Özellikleri
- **Event-Driven Architecture** - OrderCreated event'i ile sipariş işlemleri
- **Observer Pattern** - OrderItemObserver ile otomatik stok yönetimi
- **Queue Workers** - E-posta gönderimini background'da işleme
- **Policy Classes** - OrderPolicy ile detaylı yetkilendirme
- **Service Providers** - Custom service registration
- **Middleware Stack** - API rate limiting ve authentication

## 🐳 Docker ile Kurulum

### Gereksinimler
- Docker Desktop
- Docker Compose
- Git

### Adım Adım Kurulum

1. **Projeyi klonlayın:**
```bash
git clone https://github.com/Neography7/laravel-ecommerce.git
cd laravel-ecommerce
```

2. **Environment dosyasını oluşturun:**
```bash
cp .env.example .env
```

3. **Docker container'larını build edin:**
```bash
docker-compose build --no-cache
```

4. **Container'ları başlatın:**
```bash
docker-compose up -d
```

5. **Laravel uygulamasını yapılandırın:**
```bash
# APP_KEY oluşturun
docker-compose exec app php artisan key:generate

# Veritabanı migration'larını çalıştırın
docker-compose exec app php artisan migrate

# Veritabanı seeder'larını çalıştırın (test kullanıcıları dahil)
docker-compose exec app php artisan db:seed
```

### 👥 Test Kullanıcıları
Seeder çalıştırıldıktan sonra aşağıdaki test kullanıcıları ile giriş yapabilirsiniz:

**Admin Kullanıcı:**
- **E-posta:** admin@test.com
- **Şifre:** admin123
- **Yetki:** Admin (tüm işlemler)

**Normal Kullanıcı:**
- **E-posta:** user@test.com
- **Şifre:** user123
- **Yetki:** Customer (standart kullanıcı işlemleri)

### 🌐 Erişim URL'leri
- **Ana Uygulama**: http://localhost:8000
- **Laravel Telescope**: http://localhost:8000/telescope
- **API Dokümantasyonu**: http://localhost:8000/docs/api

### 🗄️ Veritabanı Bağlantısı
- **Host**: localhost
- **Port**: 5432
- **Database**: laravel_ecommerce
- **Username**: postgres
- **Password**: secret

## 🔧 Geliştirme Komutları

### Composer Komutları
```bash
# Dependency'leri yükle
docker-compose exec app composer install

# Autoload dosyalarını yenile
docker-compose exec app composer dump-autoload
```

### Artisan Komutları
```bash
# Cache temizle
docker-compose exec app php artisan cache:clear

# Config cache'i temizle
docker-compose exec app php artisan config:clear

# Route cache'i oluştur
docker-compose exec app php artisan route:cache

# Migration oluştur
docker-compose exec app php artisan make:migration create_table_name

# Model oluştur
docker-compose exec app php artisan make:model ModelName
```

### Test Komutları
```bash
# Tüm testleri çalıştır
docker-compose exec app php artisan test

# Pest testlerini çalıştır
docker-compose exec app ./vendor/bin/pest

# Code coverage raporu oluştur
docker-compose exec app php artisan test --coverage

# HTML coverage raporu oluştur
docker-compose exec app php artisan test --coverage-html coverage

# Coverage raporunu görüntüle
open coverage/index.html

# Code style kontrolü
docker-compose exec app ./vendor/bin/pint
```

## 📱 API Kullanımı

### Authentication
```bash
# Admin kullanıcısı ile giriş
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@test.com","password":"admin123"}'

# Normal kullanıcı ile giriş
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@test.com","password":"user123"}'

# Token ile korumalı endpoint örneği
GET /api/user
Authorization: Bearer {token}
```

### Temel API Endpoint'leri
```bash
# Kategoriler
GET /api/categories
POST /api/categories

# Ürünler
GET /api/products
POST /api/products
GET /api/products/{id}

# Sepet işlemleri
GET /api/cart
POST /api/cart/add
DELETE /api/cart/remove/{item}

# Sipariş işlemleri
GET /api/orders
POST /api/orders
GET /api/orders/{id}
```

## 🏗️ Laravel Mimarisi & E-Commerce Özellikleri

### Event-Driven Sipariş İşleme
```php
// Sipariş oluşturulduğunda event tetiklenir
OrderCreated::dispatch($order);

// Background'da e-posta gönderilir
SendOrderConfirmationEmail::class (implements ShouldQueue)
```

### Observer Pattern ile Stok Yönetimi
```php
// OrderItemObserver otomatik çalışır
public function created(OrderItem $orderItem): void
{
    $orderItem->product->decrement('stock_quantity', $orderItem->quantity);
}
```

### Policy Tabanlı Yetkilendirme
```php
// OrderPolicy ile erişim kontrolü
$this->authorize('view', $order);
$this->authorize('update', $order);
```

### Queue System & Background Jobs
```bash
# Queue worker'ı başlat
docker-compose exec app php artisan queue:work

# Job durumunu kontrol et
docker-compose exec app php artisan queue:status

# Failed job'ları yeniden çalıştır
docker-compose exec app php artisan queue:retry all
```

## 🛠️ Debugging ve Monitoring

### Test Kullanıcıları ile API Testleri
```bash
# Admin token al
ADMIN_TOKEN=$(curl -s -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@test.com","password":"admin123"}' | jq -r '.token')

# Admin yetkisiyle ürün oluştur
curl -X POST http://localhost:8000/api/products \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name":"Test Ürün","price":100,"category_id":1}'

# Normal kullanıcı token al
USER_TOKEN=$(curl -s -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@test.com","password":"user123"}' | jq -r '.token')

# Kullanıcı sepetini görüntüle
curl -H "Authorization: Bearer $USER_TOKEN" http://localhost:8000/api/cart
```

### Laravel Telescope
Telescope, uygulamanızın isteklerini, exception'larını, veritabanı sorgularını ve daha fazlasını izlemenizi sağlar:
- http://localhost:8000/telescope

### Log Dosyaları
```bash
# Laravel loglarını görüntüle
docker-compose exec app tail -f storage/logs/laravel.log

# Container loglarını görüntüle
docker-compose logs -f app
```

## 🤝 Katkıda Bulunma

1. Bu projeyi fork edin
2. Feature branch'i oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📝 Lisans

Bu proje [MIT lisansı](https://opensource.org/licenses/MIT) altında lisanslanmıştır.
