MODELS_DIR := ./models
# List of URLs
MODEL_DOWNLOAD_ULRS := \
    https://github.com/Hillobar/Rope/releases/download/Sapphire/79999_iter.pth \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/codeformer_fp16.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/det_10g.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/epoch_16_best.ckpt \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/faceparser_fp16.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/GFPGANv1.4.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/GPEN-BFR-512.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/inswapper_128.fp16.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/occluder.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/rd64-uni-refined.pth \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/res50.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/scrfd_2.5g_bnkps.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/w600k_r50.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/yoloface_8n.onnx \
	https://github.com/Hillobar/Rope/releases/download/Sapphire/2d106det.onnx

# Default target
.PHONY: all
all: build-docker download

# Download models
.PHONY: download
download:
	@mkdir -p $(MODELS_DIR)
	@for url in $(MODEL_DOWNLOAD_ULRS); do \
	    file=$$(basename $$url); \
	    echo "Downloading $$url to $(MODELS_DIR)/$$file"; \
	    curl -L $$url -o $(MODELS_DIR)/$$file; \
	done

.PHONY: docker
docker:
	docker compose pull Rope
	docker compose up Rope

.PHONY: build-docker
build-docker:
	docker compose build base
	docker compose build Rope
