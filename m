Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6295AF2F8
	for <lists+target-devel@lfdr.de>; Wed, 11 Sep 2019 00:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfIJWgz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 10 Sep 2019 18:36:55 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:34210 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfIJWgz (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 18:36:55 -0400
Received: by mail-io1-f48.google.com with SMTP id k13so26173908ioj.1
        for <target-devel@vger.kernel.org>; Tue, 10 Sep 2019 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tgsmc.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=TpnHQAnUwWYsWXGsSzEMmYQWCy5q9ihUDNXnYdBPMvk=;
        b=D2ZuWwYpIMDW5PgIQLH8pWlF6Z3Oz6le+Q3rRhH8EkIKNY4D1Qj7Oe09g4IdJH4Fti
         HNVX1RZ72wOhkW+JDjO2KJQJnqGyXNEgC9ig0JP1ykWXvvPXRTuM6Dtx+Oh37Cy+o1DM
         wPCbPhT8Q5Xki6s+mKvW+ij4GRjbuO7yQLatQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TpnHQAnUwWYsWXGsSzEMmYQWCy5q9ihUDNXnYdBPMvk=;
        b=BZKfcIWGZ+UFHVwTJnSKVrmG5C+bFmQRI+vzzdN5ghdr950cFVIkjyntCYk7vTOwY2
         hITtuWF8EpVMuQsGyImukOotWW/j3Zm/xrAkrDY8njRRYjSvgIRyQmcavVw7P0RzYzSf
         FFQo/19oFKQYyU8pQM4xWkT0dM7aa4g+wwZPgklzHJYHP9eiLNb0EMgOPaIcadhadpRw
         hgdVobWdO32YQyaeGb0HZc5612/Tsb4vQkFO9R0l8TeIlbQydYHsUa7vp0BnUvWOSgRC
         QaMqEK2FTVOnoJw6fXRwyyIHW8ni3EhnhTIDur5dDhePEU+TkGExC5vMKIy8KHqurPtA
         lxNg==
X-Gm-Message-State: APjAAAUSOT1QymDI0/PxTnvSWTtC1UgJZ+6zahhQeG1dyBG54nioR+Qd
        MTbBAFIp4OpTgmaEV0eWrKsrlbTgv63KQC/mmXmaDLn2Wu0oqA==
X-Google-Smtp-Source: APXvYqzvRwMNiQoZ0kdfncNo9W3Rj4NmdVmqUDn+woGbMWqIhNk+T5+DgcrknSM8HEDSUGfn8+8+lVIHHIhRs99YNik=
X-Received: by 2002:a6b:620b:: with SMTP id f11mr479202iog.85.1568155012685;
 Tue, 10 Sep 2019 15:36:52 -0700 (PDT)
MIME-Version: 1.0
From:   Josh England <josh@tgsmc.com>
Date:   Tue, 10 Sep 2019 15:36:41 -0700
Message-ID: <CAL-b+8jMoe3wBBp_6p74dkVW--pmxY52kXD869Bq_GQy1AL73A@mail.gmail.com>
Subject: prod_mode_write_protect doesn't work
To:     target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

CentOS-7.5 target and initiator.

I'm trying to expose a fileio backstore target to multiple initiators
as a read-only device, but running into problems with the read-only
part.
Setting prod_mode_write_protect=1 (or demo_mode_write_protect=1) in
the TPG does not give the expected behavior.  Initiators can still
login and happily write to the device.  Is this a bug or am I just
doing something wrong?

-JE
