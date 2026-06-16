# Refferq - Build Instructions

## 🚀 Quick Start (Local)

### 1. Install & Setup
```bash
npm install
cp .env.local.example .env.local
# Edit .env.local with your PostgreSQL URL and API keys
```

### 2. Generate Prisma & Run Migrations
```bash
npm run db:generate
npm run db:push
```

### 3. Start Development
```bash
npm run dev
```

Visit: `http://localhost:3000`

---

## 🐳 Docker Deployment

### Build Image
```bash
docker build -t refferq:latest .
```

### Run Container
```bash
docker run -p 3000:3000 \
  -e DATABASE_URL="postgresql://user:pass@host/refferq" \
  -e JWT_SECRET="your-32-char-secret" \
  -e RESEND_API_KEY="re_xxxxx" \
  -e NEXT_PUBLIC_APP_URL="https://your-domain.com" \
  refferq:latest
```

---

## ⚠️ Build Error Solutions

### "AuthMethod is not defined"
```bash
npm run db:generate
npm run build
```

### "Cannot find module '@prisma/client'"
```bash
rm -rf node_modules
npm install
npm run db:generate
```

### Database Connection Issues
- Check `DATABASE_URL` format: `postgresql://user:password@host:5432/dbname`
- Ensure PostgreSQL is running
- Verify network connectivity

### Email Not Sending
- Verify `RESEND_API_KEY` is valid
- Check sender email in `.env.local`
- Review logs in development mode

---

## ✨ Authentication Features

✅ **Password Login** - Traditional email/password  
✅ **OTP via Email** - One-time codes (10 min expiry)  
✅ **Dual Method** - Users choose their preference  
✅ **Rate Limiting** - 5 attempts/min per IP  
✅ **Session Management** - 24-hour JWT tokens  

---

## 📋 Environment Variables

**Required:**
```
DATABASE_URL=postgresql://...
JWT_SECRET=min-32-characters-long
RESEND_API_KEY=re_xxxxx
```

**Optional:**
```
NEXT_PUBLIC_APP_URL=http://localhost:3000
NODE_ENV=development
ADMIN_EMAILS=admin@example.com
PLATFORM_NAME=Refferq
```

---

## 🔧 Common Commands

```bash
npm run dev          # Start development
npm run build        # Build for production
npm start            # Run production build
npm run lint         # Lint code
npm run db:generate  # Generate Prisma Client
npm run db:push      # Run database migrations
npm run db:seed      # Seed database
```

---

## 📚 Documentation

- [BUILD_GUIDE.md](./BUILD_GUIDE.md) - Detailed build guide
- [prisma/schema.prisma](./prisma/schema.prisma) - Database schema
- [.env.local.example](./.env.local.example) - Environment variables

---

## 🆘 Support

If you encounter issues:

1. **Check logs**: `npm run dev` shows detailed errors
2. **Verify environment**: `echo $DATABASE_URL`
3. **Clear cache**: `rm -rf .next node_modules`
4. **Rebuild**: `npm install && npm run db:generate && npm run build`

