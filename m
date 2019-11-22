Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41490107907
	for <lists+target-devel@lfdr.de>; Fri, 22 Nov 2019 20:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKVTzR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 22 Nov 2019 14:55:17 -0500
Received: from us-smtp-delivery-195.mimecast.com ([216.205.24.195]:44048 "EHLO
        us-smtp-delivery-195.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbfKVTzQ (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:55:16 -0500
X-Greylist: delayed 623 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 14:55:15 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datto.com;
        s=mimecast20190208; t=1574452514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=arb5sxIWyuyPlHJCbadoJcdMPdCBpffbxVGz3HYjRHY=;
        b=SZOZGFzXekn4asq4WjJYWFvmE6GlOSzFzIxOLvwm43uOqY0LjX0x54Ey54GjWFNbFP8LSH
        EL6gjpgrcjRSuz+5Sc9PhFbZ9xsJYv93iH/ZaScgnVHh21unZ/0OThz6BVeuWIbT0DqPFM
        DVciAvuYQ+ZmCoeVph6c4VbtdffHx+I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ZNinotohOv-9HeRYKta5Kw-1; Fri, 22 Nov 2019 14:55:13 -0500
Received: by mail-qk1-f197.google.com with SMTP id w85so5008177qka.13
        for <target-devel@vger.kernel.org>; Fri, 22 Nov 2019 11:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=EnZ80WlznLgkE/cpcGS620JJf0SeDoS5sCBafqAzLzQ=;
        b=Lvosaz/85DkyR1lNELQUYDdcdyWKuBHpUGQV+aAkvuvxwAvRDTIWbXbso59arH9tGQ
         bfn8sKiYvxyFL1LUqEG0YmjUrJ6TuUJfwOjjau6PnnAudK7f2E5Xl5yabC8ByD+TJhxc
         Du+xntMEeORhU3lHeH6Z3zUIAWoofr7LoOmA5i8aaPO6TgVe/iLJXwBsjik9+XF29Qjx
         Kz2ehrJyNnk2OKMKR+b1gI039NdNETpexVq1sVZafw0BpLG8SzE1mGkV67bKZ4CCgyIG
         YgquQnvAZfpuiPtgC+dQqgouU+vTWY8CRZ6c8npqnrsUVvq76cH9YtVX73V/XOan1PTo
         HNgQ==
X-Gm-Message-State: APjAAAWN+26FNQWicmYL42J+2Ei1WLN6VfDmjfVzSLg9J/psvlq0VASl
        90ZGSCyycrWIE6lCkc1jiSYyXpUjY6Iub4XuUaY2jox/PuOHPmAECJnD9Z7/sC1zoSYMQ3gxFkJ
        ZnVPcToQzNBo4sGE586MdnOq0
X-Received: by 2002:ac8:e4a:: with SMTP id j10mr8486641qti.340.1574452512450;
        Fri, 22 Nov 2019 11:55:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcjnCsba2p59ou9SIhR1h1/iBWPmL7byFiTPyiTF7PsOmcte5SiAz5I7qcuIo4Hn+n43MfSQ==
X-Received: by 2002:ac8:e4a:: with SMTP id j10mr8486591qti.340.1574452511917;
        Fri, 22 Nov 2019 11:55:11 -0800 (PST)
Received: from scofield.lan.1eanda.com (50-241-99-157-static.hfc.comcastbusiness.net. [50.241.99.157])
        by smtp.gmail.com with ESMTPSA id d6sm2227363qtn.16.2019.11.22.11.55.10
        for <target-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 11:55:11 -0800 (PST)
From:   Matt Coleman <mcoleman@datto.com>
X-Mao-Original-Outgoing-Id: 596145310.010528-7c3088cb444c3767246854b949ab4b41
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Dangling reference preventing tpg_np completion
Message-Id: <242DD9C9-F488-4713-84F5-0AFB8EC8EE80@datto.com>
Date:   Fri, 22 Nov 2019 14:55:10 -0500
To:     target-devel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-MC-Unique: ZNinotohOv-9HeRYKta5Kw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hello,

We're migrating from ietd to LIO & targetcli and have experienced targetcli=
 processes stacking up in uninterruptible sleep. Here are some details abou=
t the platform:
- Ubuntu 16.04
- kernel 4.15.0-64-generic (package linux-image-4.15.0-64-generic version 4=
.15.0-64.73~16.04.1)
- targetcli-fb 2.1.fb43
- python3-rtslib-fb 2.1.fb57

When this occurs, targetcli/LIO interactions completely lock up: if more ta=
rgetcli commands are executed, the system will eventually have 251 instance=
s of targetcli stuck in the 'D' state, at which point DBUS refuses addition=
al connections:

root@mdcSIRIS:~# ps axo lstart,pid,stat,wchan:32,command | awk '$10=3D=3D"/=
usr/bin/targetcli" && $7~/D/ {print}' | sort -k 2.1M,4 | head -10
Mon Oct 28 00:22:42 2019  6489 D iscsit_reset_np_thread           /usr/bin/=
python3 /usr/bin/targetcli /iscsi delete iqn.2007-01.net.datto.dev.temp.mdc=
siris:agentmdc-debian7-server
Mon Oct 28 00:23:42 2019 25858 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /backstores/block delete screenshot-centos7_fb9d2=
49c-b136-4446-9340-22bc878803c0.checksum_temp
Mon Oct 28 00:24:44 2019  2755 D call_rwsem_down_write_failed     /usr/bin/=
python3 /usr/bin/targetcli /iscsi/iqn.2007-01.net.datto.dev.temp.mdcsiris:a=
gentmdc-debian7-server/tpg1/ disable
Mon Oct 28 00:25:44 2019 23585 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi delete iqn.2007-01.net.datto.dev.temp.mdcs=
iris:agentmdc-debian7-server
Mon Oct 28 00:26:44 2019  4552 D call_rwsem_down_write_failed     /usr/bin/=
python3 /usr/bin/targetcli /backstores/block delete screenshot-centos7_fb9d=
249c-b136-4446-9340-22bc878803c0.checksum_temp
Mon Oct 28 00:27:45 2019 13799 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi create iqn.2007-01.net.datto.dev.temp.mdcs=
iris:agentscreenshot-debian7
Mon Oct 28 00:28:45 2019 20693 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi/iqn.2007-01.net.datto.dev.temp.mdcsiris:ag=
entmdc-debian7-server/tpg1/ disable
Mon Oct 28 00:29:45 2019 29207 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi delete iqn.2007-01.net.datto.dev.temp.mdcs=
iris:agentmdc-debian7-server
Mon Oct 28 00:30:46 2019  7376 D call_rwsem_down_write_failed     /usr/bin/=
python3 /usr/bin/targetcli /iscsi create iqn.2007-01.net.datto.dev.temp.mdc=
siris:agentscreenshot-debian7
Mon Oct 28 00:31:46 2019 24431 D    call_rwsem_down_write_failed /usr/bin/p=
ython3 /usr/bin/targetcli /iscsi create iqn.2007-01.net.datto.dev.temp.mdcs=
iris:agentscreenshot-ubuntu1204desktop
root@mdcSIRIS:~# ps aux | grep -c [t]argetcli
251
root@mdcSIRIS:~# targetcli
org.freedesktop.DBus.Error.LimitsExceeded: The maximum number of active con=
nections for UID 0 has been reached

The kernel crash dump for the earliest targetcli process (PID 6489) is=E2=
=80=A6

Oct 28 00:26:16 mdcSIRIS kernel: [788187.169202] INFO: task targetcli:6489 =
blocked for more than 120 seconds.
Oct 28 00:26:16 mdcSIRIS kernel: [788187.169291]       Tainted: P OE 4.15.0=
-64-generic #73~16.04.1-Ubuntu
Oct 28 00:26:16 mdcSIRIS kernel: [788187.170914] "echo 0 > /proc/sys/kernel=
/hung_task_timeout_secs" disables this message.
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172072] targetcli       D 0 6489 1=
 0x00000080
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172078] Call Trace:
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172093]  __schedule+0x3d6/0x8b0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172099]  ? wake_up_state+0x10/0x20
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172103]  schedule+0x36/0x80
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172106]  schedule_timeout+0x1db/0x=
370
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172110]  ? __send_signal+0x1d4/0x4=
70
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172114]  wait_for_completion+0xb4/=
0x140
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172117]  ? wake_up_q+0x70/0x70
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172140]  iscsit_reset_np_thread+0x=
a4/0xe0 [iscsi_target_mod]
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172155]  iscsit_tpg_del_network_po=
rtal+0xf9/0x1e0 [iscsi_target_mod]
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172168]  lio_target_call_delnpfrom=
tpg+0x35/0x90 [iscsi_target_mod]
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172190]  target_fabric_np_base_rel=
ease+0x31/0x40 [target_core_mod]
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172195]  config_item_release+0x62/=
0xe0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172199]  config_item_put+0x27/0x30
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172202]  configfs_rmdir+0x1fd/0x30=
0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172208]  vfs_rmdir+0xba/0x130
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172212]  do_rmdir+0x1c7/0x1e0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172217]  SyS_rmdir+0x16/0x20
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172221]  do_syscall_64+0x73/0x130
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172225]  entry_SYSCALL_64_after_hw=
frame+0x3d/0xa2
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172228] RIP: 0033:0x7f64960f8af7
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172230] RSP: 002b:00007fff977dec68=
 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172234] RAX: ffffffffffffffda RBX:=
 00000000ffffff9c RCX: 00007f64960f8af7
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172235] RDX: 0000000000000000 RSI:=
 0000000000000000 RDI: 00007f64922f7218
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172237] RBP: 00000000026db5f0 R08:=
 0000000000000000 R09: 000000000074486c
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172239] R10: 000000000000036f R11:=
 0000000000000202 R12: 00007f6495448868
Oct 28 00:26:16 mdcSIRIS kernel: [788187.172240] R13: 0000000000637e90 R14:=
 00000000026db5f0 R15: 00007f649544acf0

The kernel crash dump for the second targetcli process (PID 25858) is=E2=80=
=A6

Oct 28 00:26:16 mdcSIRIS kernel: [788187.172246] INFO: task targetcli:25858=
 blocked for more than 120 seconds.
Oct 28 00:26:16 mdcSIRIS kernel: [788187.173356]       Tainted: P OE 4.15.0=
-64-generic #73~16.04.1-Ubuntu
Oct 28 00:26:16 mdcSIRIS kernel: [788187.174465] "echo 0 > /proc/sys/kernel=
/hung_task_timeout_secs" disables this message.
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175603] targetcli       D 0 25858 =
1 0x00000080
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175607] Call Trace:
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175615]  __schedule+0x3d6/0x8b0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175619]  schedule+0x36/0x80
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175622]  rwsem_down_write_failed+0=
x1fc/0x390
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175627]  call_rwsem_down_write_fai=
led+0x17/0x30
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175630]  ? call_rwsem_down_write_f=
ailed+0x17/0x30
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175633]  down_write+0x2d/0x40
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175637]  configfs_dir_open+0x32/0x=
80
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175640]  do_dentry_open+0x25a/0x39=
0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175644]  ? configfs_lookup+0x170/0=
x170
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175647]  vfs_open+0x4f/0x80
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175651]  path_openat+0x2ef/0x1550
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175656]  ? filename_lookup+0xf8/0x=
1a0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175661]  ? __check_object_size+0x1=
10/0x1a0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175665]  do_filp_open+0x99/0x110
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175670]  ? __check_object_size+0x1=
10/0x1a0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175673]  ? path_get+0x27/0x30
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175677]  ? __alloc_fd+0x46/0x170
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175680]  do_sys_open+0x12d/0x290
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175682]  ? do_sys_open+0x12d/0x290
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175686]  ? __audit_syscall_exit+0x=
230/0x2c0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175689]  SyS_open+0x1e/0x20
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175693]  do_syscall_64+0x73/0x130
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175696]  entry_SYSCALL_64_after_hw=
frame+0x3d/0xa2
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175699] RIP: 0033:0x7fdcd08a3160
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175700] RSP: 002b:00007ffdf044de30=
 EFLAGS: 00000206 ORIG_RAX: 0000000000000002
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175704] RAX: ffffffffffffffda RBX:=
 00007fdcccb71830 RCX: 00007fdcd08a3160
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175705] RDX: 0000000000000000 RSI:=
 0000000000090800 RDI: 00007fdcccb71830
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175707] RBP: 00007fdccfc25a68 R08:=
 0000000000000000 R09: 00007ffdf044def0
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175708] R10: 0000000001a79a35 R11:=
 0000000000000206 R12: 00007fdcd0fd3698
Oct 28 00:26:16 mdcSIRIS kernel: [788187.175710] R13: 0000000001a0d620 R14:=
 0000000000000001 R15: 00007fdccfc25a68

All other targetcli PIDs' stacks are exactly the same as PID 25858's.

iscsi_np's stack suggests that it's just waiting for connections...
[<0>] inet_csk_accept+0x281/0x330
[<0>] inet_accept+0x45/0x180
[<0>] kernel_accept+0x59/0xb0
[<0>] iscsit_accept_np+0x43/0x230 [iscsi_target_mod]
[<0>] iscsi_target_login_thread+0x366/0x1060 [iscsi_target_mod]
[<0>] kthread+0x105/0x140
[<0>] ret_from_fork+0x35/0x40
[<0>] 0xffffffffffffffff

Using bpftrace, I determined that the reset command is hanging on this code=
 in iscsit_reset_np_thread():

if (tpg_np && shutdown) {
kref_put(&tpg_np->tpg_np_kref, iscsit_login_kref_put);

wait_for_completion(&tpg_np->tpg_np_comp);
}

This bit of code is a bit hard for me to debug. The code here drops its lon=
g-held reference to the tgp_np and waits for all other outstanding referenc=
es to be dropped. However, something has not let go of its reference and so=
 the thread is currently stuck. Since I cannot find any other threads stuck=
 in an =E2=80=9Ciscsi*=E2=80=9D function, I assume that some code path forg=
ot to call kref_put() on its own, causing the struct to end up with a perma=
nent leftover reference.

I'm posting to the mailing list because I've been unable to find the missin=
g call and am hoping that this bug report will be helpful to someone famili=
ar with the life cycle of this structure.

Thank you,
Matt

