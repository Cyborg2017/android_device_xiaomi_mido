#!/bin/bash
#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

MK_ROOT="$MY_DIR"/../../..

# Required!
export DEVICE=mido
export DEVICE_COMMON=msm8953-common
export VENDOR=xiaomi

export DEVICE_BRINGUP_YEAR=2020

./../../$VENDOR/$DEVICE_COMMON/extract-files.sh $@
# Hex for goodix fingerprint
DEVICE_BLOB_ROOT="$MK_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary
patchelf --replace-needed libbinder.so libbindergx.so "$DEVICE_BLOB_ROOT"/vendor/bin/hw/android.hardware.biometrics.fingerprint@2.1-service.xiaomi_mido
patchelf --replace-needed libbinder.so libbindergx.so "$DEVICE_BLOB_ROOT"/vendor/bin/gx_fpd
patchelf --replace-needed libbinder.so libbindergx.so "$DEVICE_BLOB_ROOT"/vendor/lib64/hw/fingerprint.goodix.so
patchelf --replace-needed libbinder.so libbindergx.so "$DEVICE_BLOB_ROOT"/vendor/lib64/libfp_client.so
patchelf --replace-needed libbinder.so libbindergx.so "$DEVICE_BLOB_ROOT"/vendor/lib64/libfpservice.so

