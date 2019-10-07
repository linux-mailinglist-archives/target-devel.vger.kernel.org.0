Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B53CEC7B
	for <lists+target-devel@lfdr.de>; Mon,  7 Oct 2019 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfJGTKQ (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 7 Oct 2019 15:10:16 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:6448 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfJGTKQ (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:10:16 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 15:10:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570475417; x=1602011417;
  h=mime-version:from:date:message-id:subject:to;
  bh=qKkd59j86O9FUZiM0WpoYxgW00QFfLIb89TLtsimzfI=;
  b=Qr4YUBvg/4O+0M+VR+an9bkTHipTfXatezhW8wij4rnvjMOYGJbCR69n
   gxfStEMTgMW+hX6bpIY0lz8Dl7WwNaNZh7yNFRfGJjguL6kNlWESHI4fk
   pcTzYfgz4wMGrZeW1QC7ukZQ312LyILBOIowNKMQrVRVAXbkS98lN1BJy
   a5VjCBOEBa3csUWInEW04pXLUpxsxKj9sQKFQfMYuIyB63/lNdxccNopi
   Cc2v53s3hQY3hGmur6AoUbP5RYERJAeBYgfcPwTffogeFdON9OX9b4j+w
   LdkzF55jwOhgJSD1yd2HtnOvyxildBR+OOr6XLVEILMbqb4uhVcTi8ba8
   g==;
IronPort-SDR: aQtoo634aNrwqFtKexGrXureaMmWmHjdJdd3BUXQ9zJe/shQ3HL9eZs0ErIwLiSvTbb4dI41Sy
 /ZxKV6zP3j4kUCNeXjpq2TLrR+oEws8YDb3VIld6zf0JTLMWopQBZZWwpIBJuH0VRdHMKUJ2Hu
 520FQx9Z/VbRjcG9J8pXIy8i3EL22nAO3vfLdJRhbFZU1ZzAe5yvPiOhTNG1izl61A4TI3L/FF
 eHpWascpvUeQATUN2Mzqp9eWaPzmUFgrEm9Q/e+ytflWcCLo14F+y+m5rWzX5LWfBlnIE+Mzre
 PGk=
IronPort-PHdr: =?us-ascii?q?9a23=3Addpo7BVB4MGlX7T7ZqkXdjdbpeLV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRWGtadThVPEFb/W9+hDw7KP9fy5Aipdvt3Y6SFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMWjIZgJao91w?=
 =?us-ascii?q?bFr39VcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxZJYNAeUcJ+ZVt4byqVsAoxW9GAeiGv/gxyRUhnPqx6A2z/?=
 =?us-ascii?q?gtHR3E0QEmAtkAsG7UrNLwNKoKU++1zajJzTXeb/NRxDzy64jIfQogofqRWr?=
 =?us-ascii?q?9xccvQyUk1GAPEklmctYLoMiiI1usRqWiX9fRvWv+yi2M+rQx6vzuhxt80h4?=
 =?us-ascii?q?XXmo4YzkrI+CZ5zYovO9G0VE12bcS5HJZUsyyXMZZ9TNk4TGFyoik6z6ULuZ?=
 =?us-ascii?q?u8fCcX1psq3wXfa/mbc4iQ5RLjSfqRLS94hH17fLK/gA6/8U26xe39Usm4yV?=
 =?us-ascii?q?JKrihYntXVuHAByhje58ydRvty+Ueh3jmP1wTN5e1ePU80kq/bJ4Ygwr42iJ?=
 =?us-ascii?q?UTrVzOEjHqlEjylqObdUUp9vK25+j7YbjqvIKQOotwhw3mN6QhgM2/AeA2Mg?=
 =?us-ascii?q?gUWGib/Pyx1b3i/E35WrpKj+E6nrXXvZ3BOMQUurS5DxVL3Yk+9hazFy2m38?=
 =?us-ascii?q?gAnXkbMFJFfwqKj5TzNFHUL/D3E+u/j02xnzh12fDJILnhD47TLnjMjrjhZ6?=
 =?us-ascii?q?xx601Cxwopy9BQ+ZZUBqsGIPLpVU+i/ODfWxowKRC1xaD/BclwzJgTX0qIGK?=
 =?us-ascii?q?aSNK6UuliNoqoMKvWBLLQJtSn0MeRts/31kXImkEUBVa2o24YHZnelGPhvP0?=
 =?us-ascii?q?SeZzzrmNhXVS82vg07Rfeip1mPUC5Vamz6C74z4iETDIOgEJvZQYaskPqN0X?=
 =?us-ascii?q?H/VrRSYmFdDVbEK37ue4yAE6MFbCaTOchnujgDVaW9TIxn0xyy4kuy1bN9M+?=
 =?us-ascii?q?z88S0VsYni055+4OiX3Tw07z1/CIyi3mCCQmVo1jcJQTEx9KVyvVFtjFGOzf?=
 =?us-ascii?q?48y/ZGHNpa/OhCUgoSPJXZietgBJS6XgPHY8fMU129Q/24DjwrCNE82dkDZw?=
 =?us-ascii?q?B6AdrmxgzKxSWnH/oZmqKGALQq/a/GmXv8PcBwzzDBzqZlx10nRNZfcG6rnK?=
 =?us-ascii?q?hy8yDNCIPT1UaUjaCnceIbxiGJvFWDzHuTuglhUQd2GfHXXXEOe03Phd/ioF?=
 =?us-ascii?q?7JVfmjBalxdkNqycOEJbpXIubui1oOEPz4P9LRS2mq3Xq7H1CFyq7aP6TwfG?=
 =?us-ascii?q?BI7STPCFUD2zIT9HfOYRksBi6g+zqFJCFlDxTib166oro2k2+yUkJhl1LCVE?=
 =?us-ascii?q?Zmzbfgv0dN3fE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HFAgDmiptdh8fQVdFmDoIQhBCETY5?=
 =?us-ascii?q?ggw2CCgGGd4VZgRiKNAEIAQEBDi8BAYcfIzcGDgIDCQEBBQEBAQEBBQQBAQI?=
 =?us-ascii?q?QAQEBCA0JCCmFQII6KQGDVRF8DwImAiQSAQUBIgE0gwCCCwWiZoEDPIsmgTK?=
 =?us-ascii?q?ECwGEWQEJDYFIEnoojA6CF4ERgl0HiD2CWASBOAEBAZUsllQBBgKCEBSMVIh?=
 =?us-ascii?q?EG4IqAZcUjiyZSw8jgUWBfDMaJX8GZ4FPTxAUgWmNcQRXJJIcAQE?=
X-IPAS-Result: =?us-ascii?q?A2HFAgDmiptdh8fQVdFmDoIQhBCETY5ggw2CCgGGd4VZg?=
 =?us-ascii?q?RiKNAEIAQEBDi8BAYcfIzcGDgIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQ?=
 =?us-ascii?q?II6KQGDVRF8DwImAiQSAQUBIgE0gwCCCwWiZoEDPIsmgTKECwGEWQEJDYFIE?=
 =?us-ascii?q?noojA6CF4ERgl0HiD2CWASBOAEBAZUsllQBBgKCEBSMVIhEG4IqAZcUjiyZS?=
 =?us-ascii?q?w8jgUWBfDMaJX8GZ4FPTxAUgWmNcQRXJJIcAQE?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="81220658"
Received: from mail-lj1-f199.google.com ([209.85.208.199])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 12:03:10 -0700
Received: by mail-lj1-f199.google.com with SMTP id i18so3796123ljg.14
        for <target-devel@vger.kernel.org>; Mon, 07 Oct 2019 12:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ESofDjYlaGWbuPOVSuea9qOggnj5mZzg5iY6K5NGehg=;
        b=QNQ1m0RkGKnQmc9XtJ/szCd0awaSb8iDaPUZc0HyQrCcw7iI3O7HRrRDAsKEpc+wCx
         dUc6d65ebyxZ6m4bc5Cn3+OyjoKhYd2u+olgfCRw8x4In6Hs3nGCCG7D+lrwuRU7bxf6
         YS9dxLOXZO1clM28dOxzRVoXMasB0hssMlH0DBN1JCjoWh9KWXahA+92rb/WMwEalMbe
         KykC5NCtAOiAiAqIsYBCHn0TtQDaqbUJRJlPpw+w5v2v5FL9zj45LbY9MlWCcj5XXZb/
         Xj+nk1OKga+w+6dh+Is0XZOEqlgJ7ApbBnlRrlyLRo2UbHncvHU2dThu2W+SnHTSn+JC
         Axhg==
X-Gm-Message-State: APjAAAUD9UFOlHI0QI6BWN9AZyPP/hwN4XCOyXf4DvVXvFeUWRj9cvdN
        Dc3rElxzIYfMj0L7w17/ZhZC5uiX7C6OaIQK6T6MiHHyu1fnCwRfWhV8Lw2VKvkpjtF3086cBln
        tAB7g83KFV4xzkHWjCNwa2JSpcJ0YG9h/QNBh6s2n6w==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr19382941ljk.92.1570474987352;
        Mon, 07 Oct 2019 12:03:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPt2y/kkUfF2dViia+Gw42gIv9azn/ATOBEVLWWAlSLPnIIR6FYLzrKHUfg/QEdwY0P6m32CFv87gaTDTQITI=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr19382924ljk.92.1570474987121;
 Mon, 07 Oct 2019 12:03:07 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 12:03:50 -0700
Message-ID: <CABvMjLQxcV5UE3_j84SV3u2LxJKVoQ2G+5CZCuKtAd6A_6FDNw@mail.gmail.com>
Subject: Potential NULL pointer deference in cxgbit
To:     martin.petersen@oracle.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>, varun@chelsio.com,
        Enrico Weigelt <info@metux.net>, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi All:

drivers/target/iscsi/cxgbit/cxgbit_ddp.c:

Inside function cxgbit_ddp_sgl_check(), sg_next() could return NULL,
however, the return value of sg_next() is not checked and get
dereferenced. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
