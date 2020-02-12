Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80121159E89
	for <lists+target-devel@lfdr.de>; Wed, 12 Feb 2020 02:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgBLBMi (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 11 Feb 2020 20:12:38 -0500
Received: from mail3-bck.iservicesmail.com ([217.130.24.85]:42631 "EHLO
        mail3-bck.iservicesmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728128AbgBLBMi (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:12:38 -0500
IronPort-SDR: zI88A/hPFMNq2Y5QrZ2Yu+iAgwWsj4cnX5VZMXYeffQ9yf4IZrbPZ76xtQdIKVudBFh1R/aJRg
 BDJhv1IXgZJw==
IronPort-PHdr: =?us-ascii?q?9a23=3AZGiWIx/ppQ/Lcf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B30uocTK2v8tzYMVDF4r011RmVBNmdta4P0bOempujcFJDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTWwbalzIRi5ogndqNQaipZ+J6gszR?=
 =?us-ascii?q?fEvnRHd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOjgk+2/Vl8NwlrpWrhyhqRxl3YDaY5ybO/Vica3SZt4aWW?=
 =?us-ascii?q?hMUdpNWyBdHo+wcY0CBPcBM+ZCqIn9okMDowGgCgmwGuzv0CJDiX/x3a083O?=
 =?us-ascii?q?QqDAbL3BQ+ENISrnvUttv0NKAUUeC616TH0TLDb/VK2Tfn74jIdgwurP+WUb?=
 =?us-ascii?q?1sdsrRzFAiGgXYhVuTsYzoJy2Z2vkPvmSB8uZtW/6jh3Q5pwx+uDSiyMchh4?=
 =?us-ascii?q?/UjYwP0F/E7z92wIMtKN29T050fMCrHYNLtyGfK4t2WsQiQ3x0uCoiyr0Jp5?=
 =?us-ascii?q?q7fC8SxZQi3RHfaviHc5KW7RLnSOqcLi10hGxieL2inRmy/0+gyuviWcWuzl?=
 =?us-ascii?q?lKtTJJktjKtn8Tyxze8taLRuZ/80u7xDqC2Rzf5vtaLU07j6bWJZ4szqY1lp?=
 =?us-ascii?q?UJsETDGiH2mF/xjK+Tbkgk4van6/j5bbX8qJ6cMIl0ig7lP6syncy/B/g4Mh?=
 =?us-ascii?q?IJX2if5eux2qfv8lH+QLVPlvE2iLXWsIjGJcQHoa60GxNV3Zw56xawETimzM?=
 =?us-ascii?q?0UkmQZI1JbZh2Hi5PkO0/BIP/mF/ezmVesnylxx/DAILLhBo/BLn/ZkLfuLv?=
 =?us-ascii?q?5B7BtAwRA8wMwa659KB7UpPv3+QAnyucbeAxt/NBa7kNzqENFs6oRLYW+TD7?=
 =?us-ascii?q?XRD6TUvhfc/u8zLvOTY4kauDX9MPIuz/HrhH4931QaeP/684EQbSWAE+hrOQ?=
 =?us-ascii?q?2mZnzjyoMZHHsHpBU5SuPCg1qETSRUY33pGak742doW8qdEY7fS9X10/S61y?=
 =?us-ascii?q?ChE8gOaw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ETbQCXT0NeeiMYgtlmHgELHIF9ARg?=
 =?us-ascii?q?BAYEjAgGBVVIgEoxjhnOBTR+DQ4tof4MzhggTgWcNAQEBAQEbGgIBAYRAgko?=
 =?us-ascii?q?kPAINAgMNAQEFAQEBAQEFBAEBAhABAQsLCwQrhUqCOyKDcCAPOUoMQAEOAYY?=
 =?us-ascii?q?iAQEzpE2JAQ0NAoUegkMECoEIgRsjgTYDAQGMIRqBQT+BIyGCKwgBggGCfwE?=
 =?us-ascii?q?SAW6CSIJZBI1QEiGJQpgwgkQEeJVrgjgBD4gShDUDglgPgQuDHYMIgWeEUoF?=
 =?us-ascii?q?+n1qEE1eBIHNxMxojgh2BIE8YDZxiAkCBFxACT41qgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2ETbQCXT0NeeiMYgtlmHgELHIF9ARgBAYEjAgGBVVIgE?=
 =?us-ascii?q?oxjhnOBTR+DQ4tof4MzhggTgWcNAQEBAQEbGgIBAYRAgkokPAINAgMNAQEFA?=
 =?us-ascii?q?QEBAQEFBAEBAhABAQsLCwQrhUqCOyKDcCAPOUoMQAEOAYYiAQEzpE2JAQ0NA?=
 =?us-ascii?q?oUegkMECoEIgRsjgTYDAQGMIRqBQT+BIyGCKwgBggGCfwESAW6CSIJZBI1QE?=
 =?us-ascii?q?iGJQpgwgkQEeJVrgjgBD4gShDUDglgPgQuDHYMIgWeEUoF+n1qEE1eBIHNxM?=
 =?us-ascii?q?xojgh2BIE8YDZxiAkCBFxACT41qgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.70,428,1574118000"; 
   d="scan'208";a="335795017"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 12 Feb 2020 02:12:36 +0100
Received: (qmail 11711 invoked from network); 12 Feb 2020 01:06:36 -0000
Received: from unknown (HELO 192.168.1.163) (castilloleo@[217.217.179.17])
          (envelope-sender <peterwong@controlc3.com>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <target-devel@vger.kernel.org>; 12 Feb 2020 01:06:36 -0000
Date:   Wed, 12 Feb 2020 02:06:36 +0100 (CET)
From:   Peter Wong <peterwong@controlc3.com>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     target-devel@vger.kernel.org
Message-ID: <1686214.110455.1581469596724.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Greetings,
Please check the attached email for a buisness proposal to explore.
Looking forward to hearing from you for more details.
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

