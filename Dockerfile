FROM swift:5.4 AS build
WORKDIR /site
COPY . .
RUN swift run

FROM bearologics/nginx-static:0.3.0
COPY --from=build /site/Output /app/html