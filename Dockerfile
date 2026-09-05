FROM node:18-alpine

# إعداد العمل
WORKDIR /app

# تفعيل corepack وpnpm (نسخة افتراضية)
RUN corepack enable && corepack prepare pnpm@8.6.0 --activate || true

# انسخ package.json أولاً لتسريع التخزين المؤقت للطبقات
COPY package.json ./

# تثبيت الاعتماديات إن وُجدت
RUN if [ -f package.json ]; then pnpm install --frozen-lockfile || pnpm install; fi

# انسخ بقية المشروع
COPY . .

EXPOSE 3000

# أمر افتراضي لتشغيل بيئة التطوير
CMD ["pnpm", "dev"]
