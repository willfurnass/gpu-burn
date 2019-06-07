NVCC := nvcc

all: gpu_burn

gpu_burn: compare.ptx gpu_burn-drv.o
	$(NVCC) -o $@ gpu_burn-drv.o -O3 -lcuda -lcublas -lcudart

gpu_burn-drv.o: compare.ptx
	$(NVCC) -v --compiler-options -Wno-unused-result -O3 -c gpu_burn-drv.cpp

compare.ptx:
	$(NVCC) -arch=compute_30 -ptx compare.cu -o $@

clean:
	rm -f gpu_burn compare.ptx gpu_burn-drv.o
