ARG ALPINE_VERSION=3.18
FROM alpine:${ALPINE_VERSION} AS build

ENV CMAKE_GENERATOR=Ninja
ENV CMAKE_BUILD_PARALLEL_LEVEL=8
ENV CXX=/usr/bin/clang++

RUN apk add --no-cache \
  cmake \
  ninja \
  clang16 \
  llvm16 \
  libc-dev \
  libstdc++

WORKDIR /fsd
COPY . .

RUN mkdir build
WORKDIR /fsd/build
RUN cmake ..
RUN cmake --build .

FROM alpine:${ALPINE_VERSION} AS runner

RUN apk add --no-cache \
  libstdc++

WORKDIR /fsd
COPY --from=build /fsd/build/fsd .
WORKDIR /fsd/unix

CMD [ "../fsd" ]
