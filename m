Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5332A19FCFD
	for <lists+target-devel@lfdr.de>; Mon,  6 Apr 2020 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDFSVo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 6 Apr 2020 14:21:44 -0400
Received: from mout01.posteo.de ([185.67.36.65]:47974 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgDFSVo (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:21:44 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4653816005F
        for <target-devel@vger.kernel.org>; Mon,  6 Apr 2020 20:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1586197302; bh=9SvxI2sCN5z0Pc1vVXKXnl1EAkVxzE/O2sTqu3LX7fU=;
        h=To:From:Subject:Date:From;
        b=XK74uHUr0xj+C9vS1ChtI2q0uNbndqtLOFngArUQzeheweh+lV2G+P5KlhZYu/3gv
         cZmEaBBKzQWdj1LiOtPTfe7VHp/cdtHvfJu1CHeUt9cnvmn47qBpIjtOUVLyehBuCy
         66nY3qfMFPaO3GZkPLMtey/9VqJJFbNBbXGGsGGONAUFAYcbPYjVzA7lD7b59guBzf
         jo7yfrQqjRvFTKhTMsll234EyHfM79asYwqAhgiOLh/rUgWkxpxJuFLtBWU2lh+7f6
         SebiVOTuE1LekVhusL6FunXwBEXPXC4kin9B/jFUNQN8qEjp5Q+46NA/eykTL9Q0s/
         q4dB/UmlY6saw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48wzQF5t2Hz6tmH
        for <target-devel@vger.kernel.org>; Mon,  6 Apr 2020 20:21:41 +0200 (CEST)
To:     target-devel@vger.kernel.org
From:   Andreas Kinzler <hfp@posteo.de>
Subject: strange dm-crypt problem with qemu / LIO / vhost
Message-ID: <5e29cc94-a21d-2506-9bac-48d8d29ab85b@posteo.de>
Date:   Mon, 6 Apr 2020 20:21:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

I am trying to use a /dev/mapper/luks (via cryptsetup/LUKS) on a 
backstorage/iblock from the target/SCSI framework and pass that through 
vhost (tcm_vhost) to qemu guests. It works with Linux guests but with 
Windows guests (using the virtio-scsi pv-driver) I get tons of errors in 
dmesg:

[ 3683.403467] bio error: 00000000f33a8dcd,  err: 10
[ 3683.403612] bio error: 00000000a508ea6b,  err: 10
[ 3683.414686] bio error: 00000000f06baf1d,  err: 10
[ 3683.414767] bio error: 0000000035714712,  err: 10
[ 3683.414829] bio error: 0000000062dd8892,  err: 10
[ 3683.414883] bio error: 000000005c303a2d,  err: 10
[ 3683.414936] bio error: 0000000024d02dea,  err: 10

This is from target_core_iblock.c function "iblock_bio_done".

Any ideas? Hints?

Regards Andreas
