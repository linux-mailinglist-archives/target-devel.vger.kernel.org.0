Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3671F400E6A
	for <lists+target-devel@lfdr.de>; Sun,  5 Sep 2021 08:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhIEG01 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 5 Sep 2021 02:26:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:58325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhIEG01 (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Sun, 5 Sep 2021 02:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630823115;
        bh=Ys+NZEboVUnWFmEum0YlSuqPTHhM88xGEAWwfO8U6p8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LYQMqG0cLXy3HjfS5drEIsUBmIT4S7Y9hYcdU3/rqBUDGrBEt0aCsLWvb97F5ExXl
         ZFEAAGKmhTy6aGGybjUrPJuooDsUwREpZ0/AdSSx3QMnKWD6ccPwtIo1HWfbWdPmyv
         couumRpr9Ka4CXcF15E76Vx4W5vsD3sLTb6MB6g8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M3DJl-1mO9hO18nN-003gEy; Sun, 05 Sep 2021 08:25:15 +0200
From:   Len Baker <len.baker@gmx.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: elx: libefc: Prefer kcalloc over open coded arithmetic
Date:   Sun,  5 Sep 2021 08:24:48 +0200
Message-Id: <20210905062448.6587-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/O4hM7ALWbCPWzwIh+ID1vD4gm33Nk5xbWknmtdnrQfONIGxnAw
 KijyByAx4jKrZz6Z8MForS0A4E1MXm4O7LBF0IOjpkTwel/n1RCJPGkn/73/FbB/LgSZxbO
 iN9Ck1gE1dF1MUTr2lh35vAVXzMuQEKukMS8UwZwzN1axKoOOL2audpNJZPB4JmZpo58Lo5
 h1F5dPfVpwVDFdF8JrH7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMpzMZHxKls=:OMKsG8ZAyZXRTwqURhjP5w
 kG9d71iTnYzxIO78R418bZTDuW4sLwuCeXIu7G56B1TEhAhrZb6z1mhT+QuYVafViVHuLLw8q
 GiFS19yxGhoU9L3z5HNdZaWdwTAzyt2M3J3nG81jMg56Nxyc2Aut17XmD+7/Ou4ISwYmDogCc
 Sz3250PXheHgDE/GsWX+HpZvBd8vvgV+Nw5/qKK32O5S0Qtk3hIvDL/UsyzUnRSdyb1C9q5Xb
 cFsnb7N01eJb8R0fSiUdOReVMnaZITVUMDEnO68A5T89aA/fEctbwA411CZqMqbOFmTEOCCbU
 HRKNMSMQRjfrEfcHBkXd74f6XfGazRLzXnxjIIZN0Z/V8kIYZIQhLRerS0E5BmqtVxELsjK5+
 6IPmGC9mzz9R3hz84EDXn+mhkJw94sXLpXWrAaXZTjKkSg1UkmyTTNRYZCaiOQ7O9FFU7eJl8
 osFb+n/V261XeA0o90BAzseeQr01Ji0oVL8fIif8h5p26cF7zBJP4q/WjQFzGsDlPwZh9DTVZ
 SHDY//X7vU8qRbSnxyvf5gS8A/M+QRexUN8Uqf/lfbNqKa0dnd6h2/X0Y8+i7/aZhZB993T3q
 azPbBcIJu+L8XJma+93GR/WRYHxij6Z8InjSjXTxLow5pdBnZ8Sa0H5x2RfTfuwzvasbkELhH
 LCGHJhk1+h4vn0DiOU8c2SFqHy8pTMC1FkbnRyBsp8dlaZqY3zGDdx1vuVnMnddJqcaJlgXtB
 jwtSShhjtyFa22u2zbh/vMbPu9RhEyIaWIgeZmcEDzDeVaWpnQ6ChI26vP9aPmcmC50mFlP+s
 ZdM/f9LGtizVzxKovx2kA4sVQnlc739aFb83JiTRMoTJ2BWbLMYTcfdD1yOau4nXLT149HfE6
 xp2dHZG07MgfAk9JH6gfBGc4utFOLSKgcsPB4fsZbYsnZJ4iiNnjfDI2v5v15/DtGnWWMi4Ls
 wBCQo7HYYuron3wbndhmYS1ESMQ0tHKHT3QO6CN2W4SUrz14Nm0/7SOhAH9fPhK0V6gJbyAQO
 7xg0Dmsv6HRVWUDA4NZEI00y+vA19krVxqbLQ9VofMJY5yVyAAWnAbtNc+TjX7Ch3bdWTkAgY
 OMjhU8bzN+KIlrmXtBqNZVO+kfHadlRPqi7KRtOIV8d+Wad5cCk40TN/A==
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
count * size in the kzalloc() function.

[1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/scsi/elx/libefc/efc_fabric.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/libefc/efc_fabric.c b/drivers/scsi/elx/libef=
c/efc_fabric.c
index d397220d9e54..f9412437ad47 100644
=2D-- a/drivers/scsi/elx/libefc/efc_fabric.c
+++ b/drivers/scsi/elx/libefc/efc_fabric.c
@@ -686,7 +686,7 @@ efc_process_gidpt_payload(struct efc_node *node,
 	}

 	/* Allocate a buffer for all nodes */
-	active_nodes =3D kzalloc(port_count * sizeof(*active_nodes), GFP_ATOMIC)=
;
+	active_nodes =3D kcalloc(port_count, sizeof(*active_nodes), GFP_ATOMIC);
 	if (!active_nodes) {
 		node_printf(node, "efc_malloc failed\n");
 		return -EIO;
=2D-
2.25.1

