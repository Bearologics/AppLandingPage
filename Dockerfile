FROM swift:5.4 AS build
WORKDIR /site
COPY . .
RUN swift run

FROM nginx:alpine
COPY --from=build /site/Output /usr/share/nginx/html