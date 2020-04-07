Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA471A1016
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgDGPVc (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Apr 2020 11:21:32 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:51334 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728306AbgDGPVc (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1586272889; i=@ts.fujitsu.com;
        bh=xFX3lHdE5cBeFz9v3L70B6+Tl/LdAiJ69wEECoP/WnI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=ir7WgNrpwHiYsdNPumYm5XdmZjJLyWOZhxClwXRTZ2YWWQRmrQQ9k94ybe0r2BgCS
         iC8uYVF+w2fvWzMOJzRXoSO1t5qSTcQzt47TjAiZ4sepXvPuvFh0oBB9NU3VLPsawH
         gdTto44yIn8IBNO0QW6vKsugYVMjpYbxWCNWxXBrc8ptKxx2JCiao0RE1v/RMT+zK9
         rxDQyYTymtEphrk0Lqhf7F3pmG8NdxHD0vEzq4AJRT1/7dY/cKihU998Xq3YJKQ1NP
         k1Lm1YfYLxRBCSmoxSiPXDNrdIzPjUTW33N1tK0rUQFpXmIl4BlQw0NatNm62gFNV7
         MvpbB1BlM3Hwg==
Received: from [100.112.195.73] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 0C/D2-36772-97A9C8E5; Tue, 07 Apr 2020 15:21:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRWlGSWpSXmKPExsViZ8MRolsxqyf
  OoO+3mcXy4/+YLNYf2cBo0br0LZMDs8fHp7dYPN7vu8rm8XmTXABzFGtmXlJ+RQJrxrdT0xkL
  pjBVzLpwhbmB8R5jFyMXh5DAJEaJjiNT2CCc6YwSB5reAWU4OdgEDCRWTLrPAmKLCChIbP18D
  sxmFjCWWHpjFxuILSygJ7HvwQ4wm0VAVeLN/M/sIDavgJ1E+9cOsLiEgLxEx4HJLBBxQYmTM5
  8A2RxAc9Ql1s8TghipLbFs4WvmCYw8s5BUzUKomoWkagEj8ypGi6SizPSMktzEzBxdQwMDXUN
  DI11DSyNdIxNzvcQq3US91FLd8tTiEl1DvcTyYr3iytzknBS9vNSSTYzAEEwpOPB9B+P55e/1
  DjFKcjApifIeru6JE+JLyk+pzEgszogvKs1JLT7EKMPBoSTB6zsDKCdYlJqeWpGWmQOMB5i0B
  AePkggv83SgNG9xQWJucWY6ROoUo6KUOK8YSJ8ASCKjNA+uDRaDlxhlpYR5GRkYGIR4ClKLcj
  NLUOVfMYpzMCoJ834EmcKTmVcCN/0V0GImoMXXkrpBFpckIqSkGpgW783zDJb/89bo+fvHCmE
  +zP5WS+s3e5dP974WW7Zj6sQXxRrZom4L6vji2iMe7Uu03dZnb/A36+V5+egDpwNF/IWd2TTE
  TO+lilwXlOnYnfH2QNbxphu/jkx2llr7Tobp1HI+9T0Vj5eGzYxRnCPiuMVZVWJ1fZjVJZXZR
  6ssKx76irDrbhcqFlsZIzBzQoFP8M+w0GNvRPLFtzNXh79xl5jZyv75L3tMkFllZZKQxCsJyW
  MLTQ5UfWz/OWd9PddmwScsG6IcGRWWXZ9w9hOvou6GLqZaTaadbN1K6/19nrzYMrn518O9y4r
  n+cdavU3cotRvFDRRahUH35ePK/q8m34uc7qt4MLqoC/Kq8RSnJFoqMVcVJwIANpclao8AwAA
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-29.tower-265.messagelabs.com!1586272888!630015!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12217 invoked from network); 7 Apr 2020 15:21:28 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-29.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2020 15:21:28 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 037FLPwp015995;
        Tue, 7 Apr 2020 16:21:25 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id 469FD20504;
        Tue,  7 Apr 2020 17:21:22 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, martin.petersen@oracle.com
Subject: [PATCH 0/2] target: small fixes in pr
Date:   Tue,  7 Apr 2020 17:21:17 +0200
Message-Id: <20200407152119.29042-1-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

This small series of patches are the first and the second part
of my previous patch
    target: pr: fix PR IN, READ FULL STATUS
broken down to =C2=B4two independent patches.

The remaining parts will be handled in future patches by
Mike Christie and thus are obsolete here.


