Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595C1482AB5
	for <lists+target-devel@lfdr.de>; Sun,  2 Jan 2022 11:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiABKOh (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sun, 2 Jan 2022 05:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiABKOh (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sun, 2 Jan 2022 05:14:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55E1C061574
        for <target-devel@vger.kernel.org>; Sun,  2 Jan 2022 02:14:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e5so64354412wrc.5
        for <target-devel@vger.kernel.org>; Sun, 02 Jan 2022 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=g8Z10qgIS0EarfPNyU/0T6kl3UEk/EndXdl7judHSI4=;
        b=a6nz5EqQ++9vYtmA3mVz/xBcTiOfb7tQp2sDPBDh1+qoq8hJpjtW0Pi8AcbUMU+Y1o
         0fBxH/bO6AjoQpXBQLREGHs/+d4Azws8xtkcuzorMzHHuph/Jkd1Dtp8kreJV0ZkrbnQ
         2OXLu7GcKevE7J6PK8NuM3rYjhJVCes0X3slakrQFEnm0xrI5rYj8LSZsQD1DixF4Dda
         1Dq9BBeYpHyXMX3g0UZFJgPGSQMPghyKO7N55gA5SBjhdvUnzz1WosHlBKgEJmjUkP7p
         4k9go3JlhUeFxxS43uXOEQQ2V9suk9dyRtUa39lGPYlbVgX4LHYOX6+UHhc3/OOUcrCO
         AklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=g8Z10qgIS0EarfPNyU/0T6kl3UEk/EndXdl7judHSI4=;
        b=eMIdeISamFxl3ZlXZ720nvjHu9KzpWe9avbPsEH+Fet3ejpAgW/O5566SNWIy/4TNY
         cqBUqbP0JyHW7c/F7XC/atX0MZn5OQswXbyjhzx11Dgfa6PGemtw05RFSjum3tKdHFSz
         DQb9TInzJGaYV3WyJGRKw1IiIZy22P4eqrvbUDsMFFFR7/6cLSeA0NngkwXcPy4HP5+0
         3Sim2vrYpYryAGIkUQq0Z8EQk+5e6kbYzgKUvmVt1kb8SoVVQdJH77ZX1Ca0TUqOcAu7
         tBsiWNR++9no9tQi4jMZhBWEPPXxp0Ki1xiu6Fh41/g6lu1QqZn4+AsbNloK6U8eiRaB
         qPCA==
X-Gm-Message-State: AOAM530tSZWxJdsosLsBoVCI239rDVCxbCoCOJfEN3KOu8Qwhffe3/fX
        brJeaC0CA/Z7tALEMt8scGQ=
X-Google-Smtp-Source: ABdhPJymYOrD9+BIuc++22lPIt4KBNwI7JkyQNbxXvdR+ifUECTMsSzCzGGdheCpQ+mm7Ap5NjXytQ==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr34348877wrq.294.1641118475332;
        Sun, 02 Jan 2022 02:14:35 -0800 (PST)
Received: from [192.168.9.102] ([197.211.59.105])
        by smtp.gmail.com with ESMTPSA id y8sm34928842wrd.10.2022.01.02.02.14.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 02 Jan 2022 02:14:35 -0800 (PST)
Message-ID: <61d17b0b.1c69fb81.c58cf.3315@mx.google.com>
From:   Margaret Leung KO May-yee <richmanjatau@gmail.com>
X-Google-Original-From: Margaret Leung KO May-yee
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Sun, 02 Jan 2022 11:14:27 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Am Mrs. Margaret Leung I have a business proposal for you reach at: la67737=
777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
