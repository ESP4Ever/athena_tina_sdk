# SunXi MR813 Tina SDK

---
## **[简介]**

本仓库为Cyberdog运动控制板MR813软件开发SDK。包含：bootloader，linux kernel，rootfs，镜像打包工具等等。

## **[编译方法]**

cd到内核代码所在目录后并执行以下命令：

```shell
#进入Tina-MR813-OPEN目录
source ./build/envsetup.sh
lunch 2 （mr813_evb2-tina）
make -j1
```

注意：由于全志SDK限制，目前只能使用j1。

## **[烧写方法]**

### 单独烧写的方法

```
TBD
```

