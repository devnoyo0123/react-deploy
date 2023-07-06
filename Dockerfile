FROM node:16-alpine as builder

WORKDIR /usr/src/app

COPY package.json ./package.json

RUN npm install

# 소스를 작업폴더로 복사하고 빌드
COPY . .

RUN npm run build

FROM nginx:latest

# 위에서 생성한 앱의 빌드산출물을 nginx의 샘플 앱이 사용하던 폴더로 이동
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# 80포트 오픈하고 nginx 실행
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]