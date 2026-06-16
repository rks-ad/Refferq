#!/bin/bash

# Database setup script
# Run this to initialize the database with migrations

set -e

echo "🗄️ Setting up Refferq database..."

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "❌ DATABASE_URL environment variable is not set"
    exit 1
fi

# Generate Prisma Client
echo "📦 Generating Prisma Client..."
npx prisma generate

# Run migrations
echo "🚀 Running database migrations..."
npx prisma db push --skip-generate

# Seed database (optional)
if [ "$SEED_DB" = "true" ]; then
    echo "🌱 Seeding database..."
    npm run db:seed
fi

echo "✅ Database setup completed successfully!"
