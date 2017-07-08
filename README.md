# Configurações e Execução das aplicações no emulador OpenSGX

A seguir, listaremos todos os passos de modo a configurar e, posteriormente, rodar as aplicações no OpenSGX. Todos os algoritmos e demais funcionalidades
utilizadas para a obtenção das estatísticas avaliadas no decorrer do Trabalho de Conclusão de Curso estão aqui dispostas. 

## Requisitos Iniciais (Instalação):

Instalações necessárias antes de iniciar a configuração:

### Ubuntu:

```
$ apt-get build-dep qemu
$ apt-get install libelf-dev
```

### Fedora:

```
$ yum-builddep qemu
```

## Configuração do emulador OpenSGX:

Os passos de 1 à 5 são responsáveis por configurar o emulador OpenSGX. As instruções devem ser procedidas na ordem disposta a partir do terminal no diretório principal do OpenSGX (../opensgx). 

### 1. Compilação do QEMU:

```
$ cd qemu
$ ./configure-arch
$ make -j $(nproc)
```

### 2. Retornar ao diretório opensgx/ :

```
$ cd ..
```

### 3. Compilar a Library sgxlib:

```
$ make -C libsgx
```

### 4. Compilação do user-level code:

```
$ make -C user
```

## Execução dos algoritmos de benchmark em enclaves

Executando cada uma das aplicações MiBench em enclaves (com terminal no diretório /opensgx):

### 1. Dijkstra Small:

```
$ ./opensgx -k 
$ ./opensgx -c user/demo/dijkstra/dijkstra_small.c
$ ./opensgx -s user/demo/dijkstra/dijkstra_small.sgx --key sign.key
$ ./opensgx user/demo/dijkstra/dijkstra_small.sgx user/demo/dijkstra/dijkstra_small.conf user/dijkstra/input.dat
```

### 2. Dijkstra Large:

```
$ ./opensgx -k 
$ ./opensgx -c user/demo/dijkstra/dijkstra_large.c
$ ./opensgx -s user/demo/dijkstra/dijkstra_large.sgx --key sign.key
$ ./opensgx user/demo/dijkstra/dijkstra_large.sgx user/demo/dijkstra/dijkstra_large.conf user/dijkstra/input.dat
```

### 3. StringSearch Small:

```
$ ./opensgx -k
$ ./opensgx -c user/demo/stringsearch/pbmsrch_small.c
$ ./opensgx -s user/demo/stringsearch/pbmsrch_small.sgx --key sign.key
$ ./opensgx user/demo/stringsearch/pbmsrch_small.sgx user/demo/stringsearch/pbmsrch_small.conf
```

### 4. StringSearch Large:

```
$ ./opensgx -k
$ ./opensgx -c user/demo/stringsearch/pbmsrch_large.c
$ ./opensgx -s user/demo/stringsearch/pbmsrch_large.sgx --key sign.key
$ ./opensgx user/demo/stringsearch/pbmsrch_large.sgx user/demo/stringsearch/pbmsrch_large.conf
```

### 5. SHA Small:

```
$ ./opensgx -k
$ ./opensgx -c user/demo/sha/sha_driver.c
$ ./opensgx -s user/demo/sha/sha_driver.sgx --key sign.key
$ ./opensgx user/demo/sha/sha_driver.sgx user/demo/sha/sha_driver.conf user/demo/sha/input_small.asc
```

### 6. SHA Large:

```
$ ./opensgx -k
$ ./opensgx -c user/demo/sha/sha_driver.c
$ ./opensgx -s user/demo/sha/sha_driver.sgx --key sign.key
$ ./opensgx user/demo/sha/sha_driver.sgx user/demo/sha/sha_driver.conf user/demo/sha/input_large.asc
```

### 7. CRC32 Small:

```
$ ./opensgx -k
$ ./opensgx -c user/demo/CRC32/crc_32.c
$ ./opensgx -s user/demo/CRC32/crc_32.sgx --key sign.key
$ ./opensgx user/demo/CRC32/crc_32.sgx user/demo/CRC32/crc_32.conf user/demo/CRC32/small.pcm
```

### 8. CRC32 Large:

```
$ ./opensgx -k
$ ./opensgx -c user/demo/CRC32/crc_32.c
$ ./opensgx -s user/demo/CRC32/crc_32.sgx --key sign.key
$ ./opensgx user/demo/CRC32/crc_32.sgx user/demo/CRC32/crc_32.conf user/demo/CRC32/large.pcm
```

## Execução de cada um dos benchmark MiBench sem a utilização do emulador OpenSGX:

### 1. Dentro da pasta com cada algoritmo (ex: ./opensgx/sha):

```
$ make
```

### 2. Retornar ao diretório /opensgx:

```
$ ./cd ..
```

### 3. Execução do algoritmo anteriormente compilado:

Dijkstra Small:

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 ./dijkstra/dijkstra_small dijkstra/input.dat
```

Dijkstra Large:

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 ./dijkstra/dijkstra_large dijkstra/input.dat
```

StringSearch Small:

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 ./stringsearch/search_small
```

StringSearch Large:

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 ./stringsearch/search_large
```

SHA Small:

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 ./sha/sha sha/input_small.asc
```

SHA Large:

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 ./sha/sha sha/input_large.asc
```

CRC32 Small:

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 ./CRC32/crc CRC32/small.pcm
```

CRC32 Large:

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 ./CRC32/crc CRC32/large.pcm
```

Obs: Para verificação do número de instruções e ciclos foi utilizada a ferramenta [perf](http://www.brendangregg.com/perf.html), obtida no pacote: linux-tools-common ou linux-tools 
Após a instalação da ferramenta, utilizar antes do segundo parâmetro da instrução o comando: perf stat .

Ex.: 

```
$ ./qemu/x86_64-linux-user/qemu-x86_64 perf stat ./CRC32/crc CRC32/large.pcm
```

## Créditos e Referências:

O emulador OpenSGX contido neste repositório foi desenvolvido por **Prerit Jain**, **Soham Desai**, **Seongmin Kim**, **Ming-Wei Shih**, **JaeHyuk Lee**,
**Changho Choi**, **Youjung Shin**, **Taesoo Kim**, **Dongsu Han** e **Brent Kang** (2015). O mesmo pode ser encontrado em [OpenSGX](https://github.com/sslab-gatech/opensgx).

Os algoritmos de benchmark MiBench aqui utilizados e disponibilizados foram desenvolvidos por **Matthew Guthaus**, **Jeff Ringenberg**, **Todd Austin**, **Trevor Mudge** e **Richard Brown** (2001). Os mesmos podem ser encontrados com os demais benchmarks em [MiBench](http://vhosts.eecs.umich.edu/mibench//source.html).


## Autor

* **Mateus Trebien** - *mateust92@gmail.com*