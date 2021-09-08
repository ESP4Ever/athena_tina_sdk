#!/bin/bash
 
set -x 
openssl dgst -sha256 -out $1/firmware.signature -sign $2 $1/update.img 
cd $1
zip -P cMPXOzSlYQlJI8RkrW1ddkyw6hfRUFYPCNOtUJTAqAwYHdAphg $1/update_encry_sign.img update.img firmware.signature
rm update.img firmware.signature
openssl  smime  -encrypt -aes256  -in  $1/update_encry_sign.img   -binary  -outform DEM  -out  $1/update_double_encry_sign.img  $1/publickey.pem
rm  $1/update_encry_sign.img 
cd -

