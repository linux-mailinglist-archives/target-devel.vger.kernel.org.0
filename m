Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9794ECC7D
	for <lists+target-devel@lfdr.de>; Wed, 30 Mar 2022 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349970AbiC3SiZ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 30 Mar 2022 14:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350841AbiC3SdA (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:33:00 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1BC340DD
        for <target-devel@vger.kernel.org>; Wed, 30 Mar 2022 11:29:51 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t2so18857265qtw.9
        for <target-devel@vger.kernel.org>; Wed, 30 Mar 2022 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BUnAD3xqyyj2lm0zvOZVtbyxWcA123m5vBtT7P90vEA=;
        b=Ox3JCfBWgBk1FMHXGsEaCYgwYG01a1PVBpPUVho2oT1puYfQyzuUDwpB87xkLlhTqB
         9EkmVw1rMGlyitD5V1T2hGlLupEc+kGTquU+vemPicGXggiiKMMy1eHArJe9Z5Fwaoa4
         TDplIZSofN3T6YYpMMwGg0jaOiwE7QwPDgScZiZwhINZ969Ce2P9j5e8eD7KJmnp4EU3
         abLy1UXcagCbWYNdWxycco5ZKaRhZHnJ5I0YCXTCOS0gxkvx43AjDXfOq+mBFqpajitj
         cU1L3LUmFF2ZsWaD42AEbRqa1OFVufZqKm9nAs3FTYD3eMmwJuLVk71MvZGBOwSWgE2u
         xFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=BUnAD3xqyyj2lm0zvOZVtbyxWcA123m5vBtT7P90vEA=;
        b=zZhTfO/WzHLaxrF76tajdrqLwiVLnJDJi3umIWjmlQJk9YgpPaXYsDlOeezkU5F3mw
         /ckXUE+W6nMnfw2T37UY2PvrqS5ABF9JzG6Qi3id21hm+x5xtoh1I2/MYO04tCJs12uO
         bgkB6gTVDVL98W0K78zH8J9i5GaS1p+i3DiM6nk2vYM9SF074rXhAvdQh7ACGT/AjZ3D
         jrlCo2lHdTe3b5bJbIyDXsYpX9KCaFRq2huMqz80gEpnJBpoKCNWyd4glzvKjuZy2s/S
         qt1e1VOu7Rkgz589dxgZIclAMmAlnyfuk2BNl/VrYgd1yyxIeQc0WqhAQ03nCgb0Q/4g
         TaeA==
X-Gm-Message-State: AOAM5321vhQGLfZwF/0bx8u2Hj9oj9EJ2SZe6Bi7h+9GbusCUG2voKCs
        I2ALWifeyrxCmFndrP+UT9dqRDoHePhbqXSVRp8=
X-Google-Smtp-Source: ABdhPJxlUv/hDsMzzfzNRg3ADG9zoGYWMvmZ4Ig5oUf6dZRkcaMuQPP3/54xB5Ec2pLtYfrb3p5TwnFwf9oqa3DJR/U=
X-Received: by 2002:ac8:5c84:0:b0:2e1:eede:8b1b with SMTP id
 r4-20020ac85c84000000b002e1eede8b1bmr875164qta.228.1648664990856; Wed, 30 Mar
 2022 11:29:50 -0700 (PDT)
MIME-Version: 1.0
Reply-To: isabellasayouba0@gmail.com
Sender: stjohncatholic155@gmail.com
Received: by 2002:ac8:57c3:0:0:0:0:0 with HTTP; Wed, 30 Mar 2022 11:29:50
 -0700 (PDT)
From:   Mrs Isabella Sayouba <isabellasayouba0@gmail.com>
Date:   Wed, 30 Mar 2022 18:29:50 +0000
X-Google-Sender-Auth: OAznEuOJx6PnvMqfK-9JBkVuQoM
Message-ID: <CAHjLdGcwnTDM4TZ05KUnu-FdT4TztfR4G84AW4M8LVd43Dcgfg@mail.gmail.com>
Subject: =?UTF-8?B?44GC44GE44GV44Gk44CC?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

44GC44GE44GV44Gk44CCDQoNCua2meOCkua1geOBl+OBquOBjOOCieOBk+OBruODoeODvOODq+OC
kuabuOOBhOOBpuOBhOOBvuOBmeOAguengeOBruebruOBq+OBr+Wkp+OBjeOBquaCsuOBl+OBv+OB
jOOBguOCiuOBvuOBmeOAguengeOBruWQjeWJjeOBr+OCpOOCtuODmeODqeODu+OCteODqOOCpuOD
kOOBleOCk+OBp+OBmeOAguODgeODpeODi+OCuOOCouWHuui6q+OBp+OAgeODluODq+OCreODiuOD
leOCoeOCveOBrueXhemZouOBi+OCiemAo+e1oeOCkuWPluOCiuOBvuOBmeOAguengeOBr+OBguOB
quOBn+OBq+W/g+OCkumWi+OBhOOBpuaEn+WLleOBl+OBn+OBruOBp+OAgeOBguOBquOBn+OBq+ip
seOBmeS7peWkluOBq+mBuOaKnuiCouOBr+OBguOCiuOBvuOBm+OCk+OAguengeOBr+OAgTIwMTHl
ubTjgavkuqHjgY/jgarjgovliY3jgavjg5bjg6vjgq3jg4rjg5XjgqHjgr3jga7jg4Hjg6Xjg4vj
grjjgqLlpKfkvb/jgag55bm06ZaT5YON44GE44Gm44GE44GfU2F5b3ViYUJyb3du5rCP44Go57WQ
5ama44GX44G+44GX44Gf44CC5a2Q5L6b44Gq44GX44GnMTHlubTplpPntZDlqZrjgZfjgZ/jgIIN
Cg0K5b2844Gv44Gf44Gj44GfNeaXpemWk+e2muOBhOOBn+efreOBhOeXheawl+OBruW+jOOBp+at
u+OBq+OBvuOBl+OBn+OAguW9vOOBruatu+W+jOOAgeengeOBr+WGjeWpmuOBl+OBquOBhOOBk+OB
qOOBq+axuuOCgeOBvuOBl+OBn+OAguS6oeOBj+OBquOBo+OBn+Wkq+OBjOeUn+OBjeOBpuOBhOOB
n+OBqOOBjeOAgeW9vOOBr+e3j+mhjTg1MOS4h+ODieODq+OCkumgkOOBkeOBvuOBl+OBn+OAgg0K
77yIODAw5LiHNTAwMOODieODq++8ieilv+OCouODleODquOCq+OBruODluODq+OCreODiuODleOC
oeOCveOBrummlumDveODr+OCrOODieOCpeOCsOODvOOBrumKgOihjOOBp+OAguePvuWcqOOAgeOB
k+OBruOBiumHkeOBr+OBvuOBoOmKgOihjOOBq+OBguOCiuOBvuOBmeOAguW9vOOBr+OBk+OBruOB
iumHkeOCkuODluODq+OCreODiuODleOCoeOCveOBrumJsealreOBi+OCieOBrumHkeOBrui8uOWH
uuOBq+WIqeeUqOOBp+OBjeOCi+OCiOOBhuOBq+OBl+OBvuOBl+OBn+OAgg0KDQrmnIDov5HjgIHn
p4Hjga7ljLvogIXjga/np4HjgYznmYzjgajohLPljZLkuK3jga7llY/poYzjga7jgZ/jgoHjgas3
44O25pyI6ZaT44Gv57aa44GL44Gq44GE44Gg44KN44GG44Go56eB44Gr6KiA44GE44G+44GX44Gf
44CC56eB44KS5pyA44KC5oKp44G+44Gb44Gm44GE44KL44Gu44Gv6ISz5Y2S5Lit44Gu55eF5rCX
44Gn44GZ44CC56eB44Gu54q25oWL44KS55+l44Gj44Gf44Gu44Gn44CB56eB44Gv44GT44Gu44GK
6YeR44KS44GC44Gq44Gf44Gr5rih44GX44Gm44CB5oG144G+44KM44Gq44GE5Lq644CF44Gu5LiW
6Kmx44KS44GZ44KL44GT44Go44Gr44GX44G+44GX44Gf44CC44GC44Gq44Gf44Gv44GT44Gu44GK
6YeR44KS56eB44GM44GT44GT44Gn5oyH56S644GZ44KL5pa55rOV44Gn5Yip55So44GZ44KL44Gn
44GX44KH44GG44CC56eB44Gv44GC44Gq44Gf44Gr44GC44Gq44Gf44Gu5YCL5Lq655qE44Gq5L2/
55So44Gu44Gf44KB44Gr57eP44GK6YeR44GuMzDjg5Hjg7zjgrvjg7Pjg4jjgpLlj5bjgaPjgabm
rLLjgZfjgYTjgafjgZnjgILjgYrph5Hjga43MO+8heOBr+engeOBruWQjeWJjeOBp+WtpOWFkOmZ
ouOCkuW7uuOBpuOAgemAmuOCiuOBruiyp+OBl+OBhOS6uuOAheOCkuWKqeOBkeOCi+OBn+OCgeOB
q+S9v+OBhuOBp+OBl+OCh+OBhuOAguengeOBr+WtpOWFkOOBqOOBl+OBpuiCsuOBoeOBvuOBl+OB
n+OBjOOAgeelnuOBruWutuOCkue2reaMgeOBmeOCi+OBn+OCgeOBoOOBkeOBq+OAgeWutuaXj+OB
q+OBr+iqsOOCguOBhOOBvuOBm+OCk+OAguOBk+OBrueXheawl+OBjOengeOCkuOBqOOBpuOCguiL
puOBl+OCgeOBn+OBruOBp+OAgeelnuOBjOengeOBrue9quOCkui1puOBl+OAgealveWckuOBp+en
geOBrumtguOCkuWPl+OBkeWFpeOCjOOCi+OCiOOBhuOBq+OBk+OCjOOCkuOBl+OBpuOBhOOCi+OB
ruOBp+OBmeOAgg0KDQrov5Tkv6HjgpLlj5fjgZHlj5bjgormrKHnrKzjgIHjg5bjg6vjgq3jg4rj
g5XjgqHjgr3jga7pioDooYzjga7pgKPntaHlhYjjgpLjgYrnn6XjgonjgZvjgZfjgb7jgZnjgILj
gb7jgZ/jgIHpioDooYzjga7nj77lnKjjga7lj5flj5bkurrjgafjgYLjgovjgZPjgajjgpLoqLzm
mI7jgZnjgovmqKnpmZDmm7jjgpLnmbrooYzjgZnjgovjgojjgYbpioDooYzplbfjgavmjIfnpLrj
gZfjgb7jgZnjgILnp4HjgYzjgZPjgZPjgafov7DjgbnjgZ/jgojjgYbjgavjgYLjgarjgZ/jgYzj
gZ3jgozjgavlv5zjgZjjgabooYzli5XjgZnjgovjgZPjgajjgpLnp4Hjgavkv53oqLzjgZfjgabj
gY/jgaDjgZXjgYTjgIINCg0K44Kk44K244OZ44Op44O744K144Oo44Km44OQ5aSr5Lq644GL44KJ
44CCDQo=
