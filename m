Return-Path: <target-devel+bounces-375-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63193A7E90D
	for <lists+target-devel@lfdr.de>; Mon,  7 Apr 2025 19:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5701883C1D
	for <lists+target-devel@lfdr.de>; Mon,  7 Apr 2025 17:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AB215197;
	Mon,  7 Apr 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLpZCkf3"
X-Original-To: target-devel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81812135D1;
	Mon,  7 Apr 2025 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048140; cv=none; b=XGtB8HZFe6NGxiFQzv/yAJX0onKelz08/6sW3pq+cVzHawWZGhDanOab4YXZSHekw0RgHimaak85IfKOXn6svW634nUAxzJ+jkbpVulHeDn8Wf6K6h9qrjJ5QC4fIjM103eW0BFUNoM2CvCkCm98TimDBR1yWBoNcION0uENCVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048140; c=relaxed/simple;
	bh=1gV5wKAYIhcXsVsHpfR7Ix1lNB5pYJFNOM8j3/zUsXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hL5ouuYnwR4BQrLzbLpfY7l5B16PnPZ+oXId9/T64nFcoS6Wx6RDEoED2A1QHvwtWWH3YqnltfHSK2SNelQNATCrRp+JrJXUyfryHxL5p/7JXceV5wJBXf+kuN+9kqxZUFPZCOL89xEt6wBUNsJbS0b8w19j3wcec+w4oeWT62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLpZCkf3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c1efc457bso2669678f8f.2;
        Mon, 07 Apr 2025 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744048137; x=1744652937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gV5wKAYIhcXsVsHpfR7Ix1lNB5pYJFNOM8j3/zUsXk=;
        b=DLpZCkf3ZPZk1EbbhXQHbhsuVC8abPGTzjEqmHzOxLSa5kLS0dsado5fTl6WPvIzT1
         F46S08Z55sH+l7wFrSjCL3czz+FrUDM7mnfFUNc6meO/8YvYQQf4cPnJUUAoo/AYxmUI
         qqFbuJxZG4wW9bX2iHo8KB952WJbaL4eRQsiBEJtStIGWOOQB4c/9KVWSIqJorFOnAng
         jxvnkDShSPzjfk4eRSeGHP0erySIKR1Upo9ID7TnIKambe5JSATCWvkXoiAa/k31PhgZ
         Dczwgh5zb6kn9tlZkkQYHCnGebznXa9vra5ViL8iGM7HorknAVgJmyUEt2xenOoe01Wv
         KLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744048137; x=1744652937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gV5wKAYIhcXsVsHpfR7Ix1lNB5pYJFNOM8j3/zUsXk=;
        b=Y/2PME8B6VluPq76dl39VHbvUEJYofNSiWyc4IJuRCUbVKAc6jwh6hcEDUYMGiI5vO
         uhI8ixJNrK9I5eqjywcl1sFK8WCXtg+Z9SLuUnfJePCxKPMVBQX1tUe30PPrdA2N4IdT
         JHkJI7yaf6Wdp1TigsRh8NphKloeUoVlhW4j8XHayyeRStM/dCra6DMrsETzALrhicgg
         v0ItPoHTA9UMDWfYFV115MjqsapqXVBjuaLTIxjQKoTZ2tFstB3EuTjDLn38AT9Kjpfj
         eOJCulZbJubsUVC8SbiBtrLM6mG713gGaqprDxwg6HBiKPLEoKtk8Vz34euEbsD0KVh/
         1PYg==
X-Forwarded-Encrypted: i=1; AJvYcCVPCEhsEK1CviSDcfyeC9qWQ4l2QM2q97n4kRPs8gK1FiFsc9pICyI9uyEkA4Fb2etxUE07q4rGMWm5ihWW@vger.kernel.org, AJvYcCWUuMbKW1mmbdXf0TscQ5AdnZm+wFLwPl771tVdrXkim1Xr3JWAttOTCKQl+NBA8unv+KzWfS8ZtDZXfEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+7efyXrMb0iFZ5RnwZ/N37dMInRKoqMBI8Jgsz+x+l7uFXVS
	/A/OQl+U6KjTo8xKlsQVqcScHIld0fCcC2ZjroN86cpZB28wrSX2qlyBhnXql27wAQ==
X-Gm-Gg: ASbGncuaNwsQ73D6oFIiL13YA/8D5IbgBTBa+bxGDj+ULzQoXQrvhGuFENvtqlfjHIs
	y7m9hCwhtaKxggjhKiPPj4f5kMUvEi3MwHhvgADcT+sh60cRxnUyZaOozPG9puk42UEetQlZR2v
	qnbAm76JugkvzmUro8w8FOJFs1YoCyLTKGTBjDzhRBAxnjbRyGcxSSdfMQVP+t5ZD+J/DE5sukJ
	AE5eA5EhbF9kgY+XUWr3CR1C4hV9G8ey+qOs7sv1Ah+pjjblP8qnZVxDxoMVRe1cgZqavYglLzu
	EsbyOug6T6jdof2JiR0Pqv33RPCWPIxJZAoF7Xx4szCJNMeulIL/hCmIzqI=
X-Google-Smtp-Source: AGHT+IHvm5xHEyrihlXKOKxJKWZo3yYxmHfFKcTTI7HwXFFbKp/rPsqF3MudML2SiUaXd4RfJJ7FRg==
X-Received: by 2002:a05:6000:2512:b0:39a:d20b:5c25 with SMTP id ffacd0b85a97d-39cb35a73b2mr12028385f8f.26.1744048137095;
        Mon, 07 Apr 2025 10:48:57 -0700 (PDT)
Received: from localhost.localdomain ([78.170.183.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a6ae5sm12888149f8f.32.2025.04.07.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:48:56 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4] scsi: target: transform strncpy into strscpy
Date: Mon,  7 Apr 2025 20:48:54 +0300
Message-Id: <20250407174854.10132-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <D908SSFL0E9D.24WXC0I3O6AQB@bsdbackstore.eu>
References: <D908SSFL0E9D.24WXC0I3O6AQB@bsdbackstore.eu>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maurizio,

Unfourtunately, in version 6.14-rc2 (and also v6.14) strncpy is still there.

Best Regards,
Baris

