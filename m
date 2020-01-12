Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225F81389A4
	for <lists+target-devel@lfdr.de>; Mon, 13 Jan 2020 04:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbgAMDQA (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 12 Jan 2020 22:16:00 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:32441 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732961AbgAMDQA (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:16:00 -0500
IronPort-SDR: xPklVg+QDD4P94MdGq4ciCis47qVnnL1G+4iJ27l+RRpt2DFRwHsbHVMq/zt9d8S4DhaVicr5U
 2Mt7+ChYWy5A==
IronPort-PHdr: =?us-ascii?q?9a23=3AL/Bx7hYM9H8aHvW5yyQKIHz/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8W8bnLW6fgltlLVR4KTs6sC17ON9fq+CCddvt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdu8gSjIdtKqs8yA?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDI/923Zl9B/g7heoBOhvhBy3YnUYJuNNPp5ZKPSZ88aSn?=
 =?us-ascii?q?RYUslPUSxNG5+xb5cTD+UbIelYr5fyp14Qohu4GQmgHf3gyjlRinHx2q061f?=
 =?us-ascii?q?ouEAHf0AM+GdIFrXDYodvpOKsOVOy4yrTDwzfeYPNMwTrz5ojGcgo/r/+PQL?=
 =?us-ascii?q?x/ftbex0Y0GgPZjFiftZDpMy+J2ugTtWWQ8upuVfioi24iswx/uCagxtsyhY?=
 =?us-ascii?q?nTm4kaylfE9SN2wI0oItC4UFB0YcK6H5tKuSCaMI12Qsw5TmFooyY10aEJtY?=
 =?us-ascii?q?SncygNzZQr3R7fa/+efoWO/xntV/6RLC9miH54er+znQu+/Ea8xuHmSMW530?=
 =?us-ascii?q?xGoyRFn9TKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWc18r+ums6+T9fLrmooOQOoBuhgHgNaQhh9awAeo/Mg?=
 =?us-ascii?q?gIQWeX4/qz1Kb78U34RrVFkOE2n7HHvJzHJ8kXvLO1DgFJ3oo59RqyAC2q3d?=
 =?us-ascii?q?oYkHUfKVJKYhOHj4znO1HUJ/D4CO+yg0yynzd32f/GJLPgApLLLnjMi7rhfa?=
 =?us-ascii?q?195FVAxwYp0d9f4JdUBqsBIPLwQkPxrsDXDgclMwyoxObqEMl92ZkEWWKAHK?=
 =?us-ascii?q?CZLLrevkKW6eIxPeaMYJQYuCjyK/c7/f7il3w5lkEHfamvw5QXbGq0HvN8I0?=
 =?us-ascii?q?WWMjLQhYIdGH0FsxZ7QOH0hVmqTzFefTCxUrg66zV9D5ipXr3OXoS8vLvU5C?=
 =?us-ascii?q?qnE4ceWWdABRjYCXr0ep+bXPEDaCGSOcVqujMBXLmlDYQm0Ef9mhX9zu9fI/?=
 =?us-ascii?q?bZ4GUnspTsnIxt6vHejw418zNcD9+X2CeGSGQynmBeFGx+57x2vUEokwTL6q?=
 =?us-ascii?q?N/mfENToQL6g=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GbIwDU3xtemCMYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBewIBGAEBgS6BTVIgEpNQgU0fg0OLY4EAgx4?=
 =?us-ascii?q?VhggTDIFbDQEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhA?=
 =?us-ascii?q?BAQEBAQYNCwYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUoMQAEOAVODBIJ?=
 =?us-ascii?q?LAQEznG8BjQQNDQKFHYJKBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ/ARI?=
 =?us-ascii?q?BbIJIglkEjUISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAOEToF?=
 =?us-ascii?q?9ozdXgQwNenEzGoImGoEgTxgNiBuOLUCBFhACT4kugjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GbIwDU3xtemCMYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBewIBGAEBgS6BTVIgEpNQgU0fg0OLY4EAgx4VhggTDIFbDQEBA?=
 =?us-ascii?q?QEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhABAQEBAQYNCwYph?=
 =?us-ascii?q?UqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUoMQAEOAVODBIJLAQEznG8BjQQND?=
 =?us-ascii?q?QKFHYJKBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ/ARIBbIJIglkEjUISI?=
 =?us-ascii?q?YEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAOEToF9ozdXgQwNenEzG?=
 =?us-ascii?q?oImGoEgTxgNiBuOLUCBFhACT4kugjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,427,1571695200"; 
   d="scan'208";a="323716353"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 13 Jan 2020 04:15:58 +0100
Received: (qmail 31649 invoked from network); 12 Jan 2020 04:02:00 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <target-devel@vger.kernel.org>; 12 Jan 2020 04:02:00 -0000
Date:   Sun, 12 Jan 2020 05:01:56 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     target-devel@vger.kernel.org
Message-ID: <440365.279272.1578801720239.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

