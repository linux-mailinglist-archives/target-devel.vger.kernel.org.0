Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638372EF0DC
	for <lists+target-devel@lfdr.de>; Fri,  8 Jan 2021 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbhAHKu3 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 8 Jan 2021 05:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbhAHKu3 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:50:29 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4C6C0612F4
        for <target-devel@vger.kernel.org>; Fri,  8 Jan 2021 02:49:48 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x20so21803987lfe.12
        for <target-devel@vger.kernel.org>; Fri, 08 Jan 2021 02:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=sDAcSKfDqT8GDOZ+wnwT5fwZjsYhKjvvfGvb7zGzn+C2KeEXlD7c5kIolcGXhhna4m
         6sGCVQzLeROCbISdOeWfxMf/7RK96YIzqiCOFeJoKxtMxBfmnJ1KvsJyoNmTrVNhzdJy
         z0O6H0nolJtZDUykNfjABJnVmyaVefO85V3o+fLf0WZaUlUHDBcYepcbF9tAy3QxFzDG
         OWjCQD6qYe8qsMLBQYl0CJro07Vmvyk/iOz6zj6Tf9bRq02aX6APvrx7gdtQrGQeTy1f
         X3sru/vlTY09iaWIHl5Gi1HsOHrLlfzHr5pHNcZzJa8NE8puQXSuZAot/Bgpi2bczE/0
         vzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=Pf2OqDp/RtNYHiDAdg52o7MuC5wZP298iMLskb4W7a9lxbaiNs8K58Dz9NY4Mr+lzo
         HPlsXto09c8+ZTE+zL5U564ZWQr6j3O+U/4v/0N+ETBxZF3zqxvBh4OASZRjiHzoVN9h
         qJoZz8q4+MJhgznyZ4eKWBQVfq8Y3tSJlu6/isSMGFWlCRwW9p5D8z1QXe8tW+Ci7s2B
         N0ZamlTVnUQlQibhg4KDhOMldRCVl45qlEMhoBLU4rDYO8BsURvpyKSz85DqgXbtpE58
         O9YFb/1OpwzaDdx2EkkyCDipBSYkx4nyzm3Y00wpeIlcJ9cIV8iHTqJwIM7Bib9A9QgA
         YJUA==
X-Gm-Message-State: AOAM532Bivi0Vs/3ph7snex6Lk1vnHjRTo4E7fok0UgJNeb7dKLzQYXK
        pGtpNg0Ldvq6KG5LVwNpgGjHrLHUQUEoXTVzDQ==
X-Google-Smtp-Source: ABdhPJz8yp2C3BmeKI7ogTkYbyQ5+WTVtzuiFNO7bH9UFExBBm9weZPeG9cYe+nRVpFEofwWbco3A0NhyVpgDUsc/kM=
X-Received: by 2002:a19:a405:: with SMTP id q5mr1505285lfc.503.1610102987327;
 Fri, 08 Jan 2021 02:49:47 -0800 (PST)
MIME-Version: 1.0
Sender: kossibrewena@gmail.com
Received: by 2002:ab3:680e:0:0:0:0:0 with HTTP; Fri, 8 Jan 2021 02:49:46 -0800 (PST)
In-Reply-To: <CALKsWkgg0AquqOk4RcCsrUm-LjsRFV00m76ds94HDPOV8UZuwA@mail.gmail.com>
References: <CALKsWkgg0AquqOk4RcCsrUm-LjsRFV00m76ds94HDPOV8UZuwA@mail.gmail.com>
From:   camille <camillejackson021@gmail.com>
Date:   Fri, 8 Jan 2021 10:49:46 +0000
X-Google-Sender-Auth: sqg8-n7kV0Vugo5LUzFNnnrsTgo
Message-ID: <CALKsWkj63TTg-fGidoyPU-+5Y2YcUjpFMq828sRUysMccB2+Zg@mail.gmail.com>
Subject: =?UTF-8?B?0JfQtNGA0LDQstGB0YLQstGD0LnRgtC1LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDRgtC10LHRjywg0LzQvtC5INC00YDRg9CzLCDQvdCw0LTQ
tdGO0YHRjCwg0YLRiyDQsiDQv9C+0YDRj9C00LrQtSwg0L/QvtC20LDQu9GD0LnRgdGC0LAsINC+
0YLQstC10YLRjCDQvNC90LUNCtCx0LvQsNCz0L7QtNCw0YDRjywNCg==
