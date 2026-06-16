# Build Guide for Refferq

## Quick Start

### Prerequisites
- Node.js 20.9.0 or higher
- PostgreSQL 13 or higher
- npm or yarn

### Local Development

1. **Install dependencies:**
```bash
npm install
```

2. **Set up environment variables:**
```bash
cp .env.local.example .env.local
```

Edit `.env.local` with your configuration:
```
DATABASE_URL="postgresql://user:password@localhost:5432/refferq"
RESEND_API_KEY="your-resend-api-key"
JWT_SECRET="your-super-secret-jwt-key-minimum-32-characters"
NEXT_PUBLIC_APP_URL="http://localhost:3000"
```

3. **Generate Prisma Client:**
```bash
npm run db:generate
```

4. **Run database migrations:**
```bash
npm run db:push
```

5. **Start development server:**
```bash
npm run dev
```

Visit `http://localhost:3000`

---

## Production Build

### Docker Build

1. **Build the Docker image:**
```bash
docker build -t refferq:latest .
```

2. **Run the container:**
```bash
docker run -p 3000:3000 \
  -e DATABASE_URL="postgresql://..." \
  -e JWT_SECRET="your-secret" \
  -e RESEND_API_KEY="your-key" \
  -e NEXT_PUBLIC_APP_URL="https://your-domain.com" \
  refferq:latest
```

### Manual Build

1. **Install dependencies:**
```bash
npm ci
```

2. **Generate Prisma Client:**
```bash
npm run db:generate
```

3. **Run migrations:**
```bash
npm run db:push
```

4. **Build application:**
```bash
npm run build
```

5. **Start production server:**
```bash
npm start
```

---

## Troubleshooting

### Build Fails: "AuthMethod is not defined"

**Solution:** Make sure you've run `npm run db:generate` after updating the schema.

```bash
npm run db:generate
npm run build
```

### Build Fails: "Cannot find module '@prisma/client'"

**Solution:** Reinstall dependencies and regenerate Prisma:

```bash
rm -rf node_modules package-lock.json
npm install
npm run db:generate
npm run build
```

### Database Connection Error

**Solution:** Verify DATABASE_URL is correct:

```bash
# Test connection
psql "$DATABASE_URL"
```

### "Too many OTP requests" Error

This is expected rate limiting. Wait 60 seconds before requesting another OTP.

---

## Environment Variables

Required:
- `DATABASE_URL` - PostgreSQL connection string
- `RESEND_API_KEY` - Email service API key
- `JWT_SECRET` - Session token secret (min 32 chars)

Optional:
- `NEXT_PUBLIC_APP_URL` - Application base URL (default: http://localhost:3000)
- `NODE_ENV` - Environment (development/production)
- `ADMIN_EMAILS` - Comma-separated admin emails for notifications

---

## Authentication Methods

The system now supports three authentication modes:

1. **PASSWORD** - Traditional email/password login
2. **OTP** - One-time password via email
3. **BOTH** - Users can choose either method

### Setting Authentication Method

Users set their preferred method during registration. Admins can manage this in the user settings.

---

## Database Schema Changes

Recent updates added:
- `authMethod` field to User model
- `AuthMethod` enum (PASSWORD, OTP, BOTH)
- Improved OTP validation

Run migrations automatically:
```bash
npm run db:push
```

---

## Support

For issues:
1. Check logs: `npm run dev` (development) or container logs (Docker)
2. Verify environment variables
3. Check database connection
4. Review error messages for specific guidance

