x86-64-v3 architecture
=======================

https://discourse.ubuntu.com/t/introducing-architecture-variants-amd64v3-now-available-in-ubuntu-25-10/71312

```
$ cpuinfo
Python Version: 3.14.3.final.0 (64 bit)
Cpuinfo Version: 9.0.0
Vendor ID Raw: AuthenticAMD
Hardware Raw:
Brand Raw: AMD Ryzen 7 PRO 7840U w/ Radeon 780M Graphics
Hz Advertised Friendly: 3.2180 GHz
Hz Actual Friendly: 3.2180 GHz
Hz Advertised: (3218017000, 0)
Hz Actual: (3218017000, 0)
Arch: X86_64
Bits: 64
Count: 16
Arch String Raw: x86_64
L1 Data Cache Size: 262144
L1 Instruction Cache Size: 262144
L2 Cache Size: 8388608
L2 Cache Line Size: 1024
L2 Cache Associativity: 6
L3 Cache Size: 1048576
Stepping: 1
Model: 116
Family: 25
Processor Type:
Flags: 3dnowext, 3dnowprefetch, abm, adx, aes, amd_lbr_pmc_freeze, amd_lbr_v2, aperfmperf, apic, arat, avx, avx2, avx512_bf16, avx512_bitalg, avx512_vbmi2, avx512_vnni, avx512_vpopcntdq, avx512bitalg, avx512bw, avx512cd, avx512dq, avx512f, avx512ifma, avx512vbmi, avx512vbmi2, avx512vl, avx512vnni, avx512vpopcntdq, bmi1, bmi2, bpext, cat_l3, cdp_l3, clflush, clflushopt, clwb, clzero, cmov, cmp_legacy, constant_tsc, cpb, cppc, cpuid, cpuid_fault, cqm, cqm_llc, cqm_mbm_local, cqm_mbm_total, cqm_occup_llc, cr8_legacy, cx16, cx8, dbx, de, decodeassists, erms, extapic, extd_apicid, f16c, flush_l1d, flushbyasid, fma, fpu, fsgsbase, fsrm, fxsr, fxsr_opt, gfni, ht, hw_pstate, ibpb, ibrs, ibrs_enhanced, ibs, invpcid, irperf, lahf_lm, lbrv, lm, mba, mca, mce, misalignsse, mmx, mmxext, monitor, movbe, msr, mtrr, mwaitx, nonstop_tsc, nopl, npt, nrip_save, nx, ospke, osvw, osxsave, overflow_recov, pae, pat, pausefilter, pci_l2i, pclmulqdq, pdpe1gb, perfctr_core, perfctr_llc, perfctr_nb, perfmon_v2, pfthreshold, pge, pku, pni, popcnt, pqe, pqm, pse, pse36, rapl, rdpid, rdpru, rdrand, rdrnd, rdseed, rdt_a, rdtscp, rep_good, sep, sha, sha_ni, skinit, smap, smca, smep, ssbd, sse, sse2, sse4_1, sse4_2, sse4a, ssse3, stibp, succor, svm, svm_lock, syscall, tce, topoext, tsc, tsc_scale, umip, user_shstk, v_spec_ctrl, vaes, vgif, vmcb_clean, vme, vmmcall, vnmi, vpclmulqdq, wbnoinvd, wdt, x2apic, x2avic, xgetbv1, xsave, xsavec, xsaveerptr, xsaveopt, xsaves, xtopology  

$ /usr/lib/ld-linux-x86-64.so.2 --help
...
Shared library search path:
  (libraries located via /etc/ld.so.cache)
  /usr/lib (system search path)

Subdirectories of glibc-hwcaps directories, in priority order:
  x86-64-v4 (supported, searched)
  x86-64-v3 (supported, searched)
  x86-64-v2 (supported, searched)
```

| Level | Key Extensions & Features | Target Era / CPUs |
| --- | --- | --- |
| **x86-64-v2** | SSE3, SSSE3, SSE4.1, SSE4.2, POPCNT, CX16 (CMPXCHG16B) | 2008+ (Intel Nehalem, AMD Bulldozer) |
| **x86-64-v3** | AVX, AVX2, BMI1, BMI2, F16C, FMA, LZCNT, MOVBE | 2013+ (Intel Haswell, AMD Excavator) |
| **x86-64-v4** | AVX-512 (F, BW, CD, DQ, VL) | 2017+ (Intel Skylake-X/ICL, AMD Zen 4) |

```
# Use a last future LTS version of Ubuntu
FROM ubuntu:26.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip pipx \
    ninja-build build-essential \
    git time \
    ripgrep emacs-nox

RUN pipx install meson pyperformance
```


```
Dockerfile --- Text
 4 # Prevent interactive prompts during package installation                                    4 # Prevent interactive prompts during package installation
 5 ENV DEBIAN_FRONTEND=noninteractive                                                           5 ENV DEBIAN_FRONTEND=noninteractive
 6                                                                                              6
 .                                                                                              7 # Enable new architecture variants amd64v3
 .                                                                                              8 RUN echo 'APT::Architecture-Variants "amd64v3";' | tee /etc/apt/apt.conf.d/99enable-amd64v3
 .                                                                                              9
 7 # Install system dependencies                                                               10 # Install system dependencies
 8 RUN apt-get update && apt-get install -y \                                                  11 RUN apt update && apt upgrade -y && apt-get install -y \
 9     python3 python3-pip pipx \                                                              12     python3 python3-pip pipx \
10     ninja-build build-essential \                                                           13     ninja-build build-essential \
11     git time \                                                                              14     git time \
```



```
$ 
Performance version: 1.14.0
Python version: 3.13.12 (64-bit)
Report on Linux-6.18.9-arch1-2-x86_64-with-glibc2.42
Number of logical CPUs: 16
Start date: 2026-02-18 16:36:29.944872
End date: 2026-02-18 16:38:21.488781

### fastapi_http ###
Mean +- std dev: 164 ms +- 11 ms

### xml_etree_parse ###
Mean +- std dev: 89.3 ms +- 2.8 ms

### xml_etree_iterparse ###
Mean +- std dev: 59.6 ms +- 1.7 ms

### xml_etree_generate ###
Mean +- std dev: 50.7 ms +- 1.3 ms

### xml_etree_process ###
Mean +- std dev: 35.9 ms +- 1.3 ms
```

```
Performance version: 1.14.0
Python version: 3.13.12 (64-bit)
Report on Linux-6.18.9-arch1-2-x86_64-with-glibc2.42
Number of logical CPUs: 16
Start date: 2026-02-18 16:32:10.268258
End date: 2026-02-18 16:33:58.341066

### fastapi_http ###
Mean +- std dev: 157 ms +- 4 ms

### xml_etree_parse ###
Mean +- std dev: 81.2 ms +- 1.0 ms

### xml_etree_iterparse ###
Mean +- std dev: 54.6 ms +- 1.0 ms

### xml_etree_generate ###
Mean +- std dev: 48.9 ms +- 0.7 ms

### xml_etree_process ###
Mean +- std dev: 34.5 ms +- 0.5 ms
```


fastapi_http From 164 ms +- 11 ms to  157 ms +- 4 ms


* https://www.phoronix.com/review/ubuntu-2510-amd64v3  
* https://www.phoronix.com/news/Ubuntu-Server-25.10-amd64v3  

--

https://docs.google.com/presentation/d/158AOPWI1t8cMzetGhI-RGtDGnSPKIVnfposbVX9n1w4/edit?slide=id.g3c98d0a83f6_0_61#slide=id.g3c98d0a83f6_0_61
