Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB9A2751
	for <lists+target-devel@lfdr.de>; Thu, 29 Aug 2019 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfH2TdD (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 29 Aug 2019 15:33:03 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:46492 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfH2TdD (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:33:03 -0400
Received: by mail-lj1-f169.google.com with SMTP id f9so4121123ljc.13
        for <target-devel@vger.kernel.org>; Thu, 29 Aug 2019 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHXIYZX0rWUfJEAb1EyFM/v9E8Kp5RDcaJHIqouzHLA=;
        b=CEzmqVx/UlcL6foEV4RMiuHGRb14pYdj9RvRMkoyo9v7gGCWHCKpvnxnhdVYtZnsN+
         mlkO5CmGPnXRcgb1PDRfYigh2EZhOPZlBTEf9hY7PYL4PPPlQ7O5vQDiwC9Ge0In90q3
         RvJF9hte0r5i1LQTVZEeXRJg75Ub7D0AtA7KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHXIYZX0rWUfJEAb1EyFM/v9E8Kp5RDcaJHIqouzHLA=;
        b=DNN8C8sEIdPhWFZuTDDcQAZjGaq2LeNW0C6p0T7Uq87dkzdoBnvO7WyAXxR1ixqmK/
         sx+YW97hUoywo3YrrqQLXtF2N+7cbVUFQn8ECOHoHcDx4h2q9K+RClE18R8HeHjb5FQ0
         JqiV3hsqPkZnS3zMlZz9ofA3C6a6oLVv/ide1K2BZ71n/aSw0z4Dg5MN9vbnzp14BDLI
         xpjYZ9mlFbW2l5T8429Ppogvg4/8Iprf5v1uvWwCJySsOBWca17WehqvT893p59zTjKc
         vuhejhr2vbUencY7vK5EE9HaGpLtYrtdizp1Bbyr2Sdt5gZc6v7i8N8rGqoKLOrCtBGN
         17gw==
X-Gm-Message-State: APjAAAUBifMTzxpyWmtExDjkaGsKwvgdV0doQLVqYG5YKJLvukox++tV
        tVf40i15PvVLGRqqXBCVzZT9MrRVaM0=
X-Google-Smtp-Source: APXvYqyJuKFpJhl2KfxyyJYmwS1W0Ewi+TnHutMkDOfhatPtoZYFM5Gz0an+HDKXMGinH5+L29r+Pw==
X-Received: by 2002:a05:651c:1036:: with SMTP id w22mr6322117ljm.79.1567107180472;
        Thu, 29 Aug 2019 12:33:00 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b11sm527500lfi.91.2019.08.29.12.32.58
        for <target-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 12:32:58 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id h15so4144295ljg.10
        for <target-devel@vger.kernel.org>; Thu, 29 Aug 2019 12:32:58 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr6437923lji.52.1567107177876;
 Thu, 29 Aug 2019 12:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <8ce9f318994535cc9c15e5c67e2b5383df3bc40a.camel@foxmail.com>
 <20190722114700.GE3089@kadam> <20190722115010.GF3089@kadam>
 <5c803b0a07ca822f9474f9b438ed924092c5df4b.camel@foxmail.com>
 <20190802073057.GD26174@kroah.com> <5d49567f.1c69fb81.97950.e58aSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAHk-=wgQeKWHW0bQ1aV5=2ivbD-WWDHcBBJ_cX5R75iiNNq2uA@mail.gmail.com>
In-Reply-To: <CAHk-=wgQeKWHW0bQ1aV5=2ivbD-WWDHcBBJ_cX5R75iiNNq2uA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Aug 2019 12:32:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3EKnDXnt681b0+11UbiA8roO8Ui==eKVaKU4pnPe7rw@mail.gmail.com>
Message-ID: <CAHk-=wh3EKnDXnt681b0+11UbiA8roO8Ui==eKVaKU4pnPe7rw@mail.gmail.com>
Subject: Re: Bug report: KFIFO kfifo_init() may introduce buffer overflow
To:     laokz <laokz@foxmail.com>
Cc:     Greg KH <greg@kroah.com>, Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        stefani <stefani@seibold.net>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        target-devel <target-devel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a9f8cb05914692e8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

--000000000000a9f8cb05914692e8
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 29, 2019 at 11:48 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anybody?

This is ENTIRELY UNTESTED.

Anybody willing to test and take ownership?

              Linus

--000000000000a9f8cb05914692e8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jzx34vq80>
X-Attachment-Id: f_jzx34vq80

IGluY2x1ZGUvbGludXgva2ZpZm8uaCB8IDEyICsrKysrKysrLS0tLQogbGliL2tmaWZvLmMgICAg
ICAgICAgIHwgIDQgKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva2ZpZm8uaCBiL2luY2x1ZGUv
bGludXgva2ZpZm8uaAppbmRleCBmYzRiMGIxMDIxMGYuLjA3OGY1MmMyMGFhZCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9rZmlmby5oCisrKyBiL2luY2x1ZGUvbGludXgva2ZpZm8uaApAQCAt
MTE3LDYgKzExNywxMiBAQCBzdHJ1Y3Qga2ZpZm9fcmVjX3B0cl8yIF9fU1RSVUNUX0tGSUZPX1BU
Uih1bnNpZ25lZCBjaGFyLCAyLCB2b2lkKTsKICAqLwogI2RlZmluZSBERUNMQVJFX0tGSUZPKGZp
Zm8sIHR5cGUsIHNpemUpCVNUUlVDVF9LRklGTyh0eXBlLCBzaXplKSBmaWZvCiAKKyNkZWZpbmUg
VkVSSUZZX1BPV0VSX09GMih4KSBcCisJKCh4KStCVUlMRF9CVUdfT05fWkVSTygoeCkgJiAoKHgp
LTEpKSkKKworI2RlZmluZSBfX0tGSUZPX01BU0tfU0laRShmaWZvKSBcCisJKF9faXNfa2ZpZm9f
cHRyKCYoZmlmbykpID8gMCA6IFZFUklGWV9QT1dFUl9PRjIoQVJSQVlfU0laRSgoZmlmbykuYnVm
KSkgLSAxKQorCiAvKioKICAqIElOSVRfS0ZJRk8gLSBJbml0aWFsaXplIGEgZmlmbyBkZWNsYXJl
ZCBieSBERUNMQVJFX0tGSUZPCiAgKiBAZmlmbzogbmFtZSBvZiB0aGUgZGVjbGFyZWQgZmlmbyBk
YXRhdHlwZQpAQCAtMTI3LDcgKzEzMyw3IEBAIHN0cnVjdCBrZmlmb19yZWNfcHRyXzIgX19TVFJV
Q1RfS0ZJRk9fUFRSKHVuc2lnbmVkIGNoYXIsIDIsIHZvaWQpOwogCXN0cnVjdCBfX2tmaWZvICpf
X2tmaWZvID0gJl9fdG1wLT5rZmlmbzsgXAogCV9fa2ZpZm8tPmluID0gMDsgXAogCV9fa2ZpZm8t
Pm91dCA9IDA7IFwKLQlfX2tmaWZvLT5tYXNrID0gX19pc19rZmlmb19wdHIoX190bXApID8gMCA6
IEFSUkFZX1NJWkUoX190bXAtPmJ1ZikgLSAxO1wKKwlfX2tmaWZvLT5tYXNrID0gX19LRklGT19N
QVNLX1NJWkUoZmlmbyk7IFwKIAlfX2tmaWZvLT5lc2l6ZSA9IHNpemVvZigqX190bXAtPmJ1Zik7
IFwKIAlfX2tmaWZvLT5kYXRhID0gX19pc19rZmlmb19wdHIoX190bXApID8gIE5VTEwgOiBfX3Rt
cC0+YnVmOyBcCiB9KQpAQCAtMTQ3LDkgKzE1Myw3IEBAIHN0cnVjdCBrZmlmb19yZWNfcHRyXzIg
X19TVFJVQ1RfS0ZJRk9fUFRSKHVuc2lnbmVkIGNoYXIsIDIsIHZvaWQpOwogCQkJeyBcCiAJCQku
aW4JPSAwLCBcCiAJCQkub3V0CT0gMCwgXAotCQkJLm1hc2sJPSBfX2lzX2tmaWZvX3B0cigmKGZp
Zm8pKSA/IFwKLQkJCQkgIDAgOiBcCi0JCQkJICBBUlJBWV9TSVpFKChmaWZvKS5idWYpIC0gMSwg
XAorCQkJLm1hc2sJPSBfX0tGSUZPX01BU0tfU0laRShmaWZvKSwgXAogCQkJLmVzaXplCT0gc2l6
ZW9mKCooZmlmbykuYnVmKSwgXAogCQkJLmRhdGEJPSBfX2lzX2tmaWZvX3B0cigmKGZpZm8pKSA/
IFwKIAkJCQlOVUxMIDogXApkaWZmIC0tZ2l0IGEvbGliL2tmaWZvLmMgYi9saWIva2ZpZm8uYwpp
bmRleCAxMTdhZDBlN2ZiZjQuLjdmMTQ1Y2I0MWU2ZCAxMDA2NDQKLS0tIGEvbGliL2tmaWZvLmMK
KysrIGIvbGliL2tmaWZvLmMKQEAgLTY4LDcgKzY4LDkgQEAgaW50IF9fa2ZpZm9faW5pdChzdHJ1
Y3QgX19rZmlmbyAqZmlmbywgdm9pZCAqYnVmZmVyLAogewogCXNpemUgLz0gZXNpemU7CiAKLQlz
aXplID0gcm91bmR1cF9wb3dfb2ZfdHdvKHNpemUpOworCS8qIFdhcm4gYmVjYXVzZSB3ZSBoYWQg
YSBidWcgaGVyZSBhbmQgd291bGQgcm91bmQgdXAgKi8KKwlpZiAoV0FSTl9PTl9PTkNFKCFpc19w
b3dlcl9vZl8yKHNpemUpKSkKKwkJc2l6ZSA9IHJvdW5kZG93bl9wb3dfb2ZfdHdvKHNpemUpOwog
CiAJZmlmby0+aW4gPSAwOwogCWZpZm8tPm91dCA9IDA7Cg==
--000000000000a9f8cb05914692e8--
