# Use the official PHP image with Apache
FROM php:8.3-apache

# Copy custom Apache config
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libzip-dev \
    libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql intl zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy application source to the image
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Run Composer install to install the dependencies
RUN git config --global --add safe.directory /var/www/html
RUN composer install --no-interaction --no-plugins --no-scripts --prefer-dist

# Adjust file permissions
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80