PROTOC=grpc_tools_ruby_protoc
PROTO_FILES=./protos/*.proto
OUTPUT_PATH=./src/pbs
INPUT_PATH=./protos

all: build

build:
	@rm -rf $(OUTPUT_PATH)
	@mkdir $(OUTPUT_PATH)
	@$(PROTOC) -I $(INPUT_PATH) --ruby_out=$(OUTPUT_PATH) --grpc_out=$(OUTPUT_PATH) $(PROTO_FILES)

.PHONY: clean

clean:
	@rm -rf $(OUTPUT_PATH)
