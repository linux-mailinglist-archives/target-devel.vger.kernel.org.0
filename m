Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7EB19D929
	for <lists+target-devel@lfdr.de>; Fri,  3 Apr 2020 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbgDCOca (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 3 Apr 2020 10:32:30 -0400
Received: from mail3.bemta25.messagelabs.com ([195.245.230.83]:36093 "EHLO
        mail3.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgDCOca (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1585924348; i=@ts.fujitsu.com;
        bh=QzdoFUeX86eHHVXVp0fvGvmk9oy+Bx/Y2E+ELXRBWW0=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=dH9WPFH3Bhg/DOOFRumKHDzh7SKU5t62NZoo/F4YwKND7SUyXS2DwN386vIhpLW23
         0yFcN0arj6702fMqpNPNcCktwf1yrcIrBaTz8FaCU1dGQENXo6XQD8PBARw1ywciLq
         nQbSd3mB+p1O4pwm+r/174JQpEQqsGFHG17YnrSkO0JE9aSsgZfeUa6Iop6tqYr4Oh
         jYnr5wErDz4ynnurYlLk9UmgKWycwHvju4gvS3j6+nNsYkeoReXwjf/Tmit+c/7RPR
         Lbx5xZJbwpjSQtBPKP/OgBK0JRpEbucWzJeu72/SBVtXQPv6+s2BOOeZRqr5vunOrU
         aAMrgmArICS3A==
Received: from [100.112.199.204] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id C3/EB-36764-CF8478E5; Fri, 03 Apr 2020 14:32:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRWlGSWpSXmKPExsViZ8MxVfePR3u
  cwcn/HBZf/09nsVi5+iiTxfLj/5gs1h/ZwGjRuvQtkwOrx+6bDWweH5/eYvF4v+8qm8fm09Ue
  nzfJBbBGsWbmJeVXJLBmHJqzlKlgPlNFX+9qlgbGD4xdjFwcQgKTGCVm/zrLBuFMB3I2H2bvY
  uTkYBMwkFgx6T4LiC0ioCCx9fM5MJtZwE9i3ZdjzCC2sECQxJuW+WD1LAKqErdfLAGr4RWwk1
  j2fTkTiC0hIC/RcWAyywRGzgWMDKsYzZOKMtMzSnITM3N0DQ0MdA0NjXQNLS11Tc31Eqt0k/R
  SS3XLU4tLdA31EsuL9Yorc5NzUvTyUks2MQJDI6XguOUOxqdr3+sdYpTkYFIS5f1r0R4nxJeU
  n1KZkVicEV9UmpNafIhRhoNDSYJ3oTtQTrAoNT21Ii0zBximMGkJDh4lEd7DbkBp3uKCxNziz
  HSI1ClGRSlx3lcgCQGQREZpHlwbLDYuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmFQRGmh
  BPZl4J3PRXQIuZgBZfrWgGWVySiJCSamBKr+lMOP1JMnHbVZOw90qmi823tfKyqt+f+Hl3QPd
  plkZRnl+6E9Si/ZXqame3nprDJqOeIfYvc/LNh4uDPgpwNq7rN9Z5u21GtNzsE6lPg39aTI/7
  wWLQen9X9007jradlfMYnN4+U0ha23NZPFY67H/Iu+ZZb+Kfbys7ZbFxidinm4dNTpeJnlvVU
  hBg75nqsic1u+iJvMT7PY+K5NrNO589rflgMuOmpmbHud3cNzecfiKv+OLg+g23w+6xzTC7sy
  zVMsGgmeNFlsusDk2/R1LbOxcnnrwR6lXB2PuB3//89juuPXdVNite/3p2QXdfvaTXrFWTEl/
  aMd783669TUHYTTrxldZOtT87Q62VWIozEg21mIuKEwHHtKgUCAMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-31.tower-285.messagelabs.com!1585924347!1556702!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24275 invoked from network); 3 Apr 2020 14:32:28 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-31.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Apr 2020 14:32:28 -0000
Received: from x-serv01 ([172.17.38.52])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id 033EWKQG004360;
        Fri, 3 Apr 2020 15:32:20 +0100
Received: from VTC.emeia.fujitsu.local (unknown [172.17.38.7])
        by x-serv01 (Postfix) with ESMTP id CD36E2066E;
        Fri,  3 Apr 2020 16:32:16 +0200 (CEST)
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     target-devel@vger.kernel.org
Cc:     mchristi@redhat.com, ddiss@suse.de, hch@lst.de,
        martin.petersen@oracle.com
Subject: [PATCH 0/2] target: make TRANSPORT_FLAG_PASSTHTROUGH_PGR/_ALUA changeable
Date:   Fri,  3 Apr 2020 16:32:12 +0200
Message-Id: <20200403143214.18303-1-bstroesser@ts.fujitsu.com>
X-Mailer: git-send-email 2.12.3
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,

By making TRANSPORT_FLAG_PASSTHTROUGH_PGR/_ALUA writeable via
attributes, this small series of patches will allow to have full
passthrough in TCMU including pr and alua.

It also allows to switch off pr passthrough in pscsi, which enables
pr support from core.

Best regards,
Bodo

