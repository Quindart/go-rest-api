# Go CLI Guide (Backend)

## 1) Chuẩn bị

Yêu cầu:
- Go 1.22+ (khuyến nghị)
- `make`
- (Tùy chọn) `golangci-lint`

Kiểm tra nhanh:

```bash
go version
make --version
```

## 2) Cấu trúc lệnh chính

Tại thư mục `backend/`, chạy:

```bash
make help
```

Các target chính:
- `make init MODULE_NAME=github.com/user/project`: khởi tạo `go.mod` (chỉ khi chưa có module)
- `make deps`: tải dependencies
- `make tidy`: đồng bộ `go.mod` / `go.sum`
- `make fmt`: format code
- `make vet`: kiểm tra lỗi tĩnh cơ bản
- `make test`: chạy unit test
- `make lint`: chạy `golangci-lint` (nếu chưa cài sẽ fallback sang `fmt + vet`)
- `make check`: chạy chuỗi `fmt + vet + test`
- `make run`: chạy app từ package hiện tại (`.`)
- `make build`: build binary vào `bin/go-rest-api`
- `make clean`: xóa thư mục `bin/`

## 3) Luồng làm việc khuyến nghị

### Lần đầu setup

```bash
make deps
make tidy
```

### Trong quá trình phát triển

```bash
make fmt
make vet
make test
make run
```

Hoặc chạy nhanh một lệnh:

```bash
make check
```

### Trước khi đẩy code

```bash
make lint
make build
```

## 4) Ghi chú

- Nếu `go.mod` chưa được khai báo, dùng `make init MODULE_NAME=...` trước.
- Nếu chưa cài `golangci-lint`, target `make lint` vẫn chạy được nhờ fallback.
- Có thể đổi tên binary bằng biến:

```bash
make build APP_NAME=my-api
```

