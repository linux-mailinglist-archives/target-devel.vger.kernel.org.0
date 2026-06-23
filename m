Return-Path: <target-devel+bounces-1228-lists+target-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+target-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RER0JFjNOmpvHQgAu9opvQ
	(envelope-from <target-devel+bounces-1228-lists+target-devel=lfdr.de@vger.kernel.org>)
	for <lists+target-devel@lfdr.de>; Tue, 23 Jun 2026 20:15:52 +0200
X-Original-To: lists+target-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED56B965C
	for <lists+target-devel@lfdr.de>; Tue, 23 Jun 2026 20:15:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hhkT2zo2;
	dkim=pass header.d=redhat.com header.s=google header.b=e3Fus4WI;
	spf=pass (mail.lfdr.de: domain of "target-devel+bounces-1228-lists+target-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="target-devel+bounces-1228-lists+target-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6BB1300F7BA
	for <lists+target-devel@lfdr.de>; Tue, 23 Jun 2026 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB238B7BA;
	Tue, 23 Jun 2026 18:14:48 +0000 (UTC)
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA035E1A1
	for <target-devel@vger.kernel.org>; Tue, 23 Jun 2026 18:14:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238488; cv=none; b=lpm5zDWJ4R1Qq1tCl+rsJ2oUEBg/t2Mq2pEgTuDY8TOBFWBDC8aFmTw++y/SqWtH0QHgBXUkxkv5Rb2hhQPbSJgdZRaMgja5P1AxI51lcfyZf5Q6GaeEtqqu8myDVtMnA0MmBylEAr96dCTA6ZiDL2evxjtXL696mBExSi/MSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238488; c=relaxed/simple;
	bh=2FJFv6ja9SLli1Ny3Bg+wtadHE94755G24WGdTn94Gs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gXMjcHVcicUZPm6X9b224PCl/CIRiIAkVbxXMVvRy3v5m/TDG37dsaPpBLypI/RRKq91+qrtK4h0o74+lYb5vhiSDytPaV3aqSX+MwsqB/pZb6IoMgVk2dL1iy3gEcvO1+bH7h7Fr0S1AASA7fQPr/F03nJpda0EQVoODa2xUSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhkT2zo2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3Fus4WI; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782238486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=el3YlPAL8xW8IojOXrxLcxZDBt50oG+HTJTkVO4TVQI=;
	b=hhkT2zo2uZnrb++i9C+6gEv9NqCmbTlmYkISWPyrC/OFHSV0M8VoYI9QTFTk3jDq4k9qPT
	xamkaNs2oKH3/tNWaylndyvvLLnKXIwY6RV6VxVpEAUvZaUAywaHSnYGBSzxMZAXN5QSiA
	WaalegD0AE2uSX+IQbze+G8MZA6cnas=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-MACsgS2COA-IVQoHlJNrKA-1; Tue, 23 Jun 2026 14:14:45 -0400
X-MC-Unique: MACsgS2COA-IVQoHlJNrKA-1
X-Mimecast-MFC-AGG-ID: MACsgS2COA-IVQoHlJNrKA_1782238484
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7ff58c89959so7374407b3.0
        for <target-devel@vger.kernel.org>; Tue, 23 Jun 2026 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782238484; x=1782843284; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=el3YlPAL8xW8IojOXrxLcxZDBt50oG+HTJTkVO4TVQI=;
        b=e3Fus4WImZQuLdX6UzVQwp6V4Innn3WOxNBe4uLSCOkoG7xLD7vSQlO4fm4EIzGgdz
         VDkMIBOUVxgcO/5Rm6P6oHby1OVZelIXl/8x7l35Yu8hWPpdKywYHre4ozwOXlQvqE4t
         piD5NMEjtTwK2zsZvGIr4D/cmp1zYb5fKij+ApwhK04WTfvpdrlqhZmuoWrlUJThgezX
         DBSsfjpoh2T7zwjOIm6ZY4GHuy1PasJSedzFB6Qjk+EffLNNO0USpfwYWHUp4krzk0nK
         Rk2w+NvNh+qSlCM3pyqjclTbz44Kj9dp1Psw8nB8kfbfeC5Qu3s5uR7rYoBZk31h73u6
         /5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782238484; x=1782843284;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=el3YlPAL8xW8IojOXrxLcxZDBt50oG+HTJTkVO4TVQI=;
        b=UGZvXhtPdnL4jJDZM2LUQvDD4eNR/AUnJjcsNJPCE2moKLmqxxQ2SLteSRTKTHN0EI
         HiwzjvpWBGD/2e2bHXD/OvEwXbOWj4K7tnUjckfyA1MwHx0yD43bKSibtSublpFpmfsX
         GQZggrIewnrHybmLAMhTOtfaH4vxaIE0NtJ/DCu7qUi1/3ibeyYzx6lemH53VnmOZcDG
         jpzyqm94GQYdC/TY0hTvpIt3qY3nExCsWClj7GwG+jOelwOG8F6NXjTu7kZbi1Omw78y
         bdiLgQsfQgtRU85sIvc0xCySl4ljgXjMQZC1V4QJFFgytSJ4obeaUio7kzJRIh65QL2R
         cXzQ==
X-Gm-Message-State: AOJu0YxCGY+bOOmb3MdIAXBQW2DzLYH/deZIEs62LYe3F+mfW1Jd1wmy
	cZVwvpEF2UEFcdU/SocbyprVRRnyqA34/hGnD8vgL+XtwXdHnM1EaecCxgZ8lTaw0ebpmjIWyhM
	hYcHuUG6m76ASAWoLBJCXTbNS2E95R4twnqqF0NGx47KVNreQqIzryh6+9MTrr1ZK1cIBH7bfnH
	WY4SVIsTpFLS812OW7s0d192y1RRPFeaPkeG6vZgHy5BcMRdgzig==
X-Gm-Gg: AfdE7cn5bQpQeNQRK6ycVZK56wNr5TkLcVnoXN9ERAE5HA/KWnmFaPOlReFuf3k1mpT
	Zu6fbFyrB+TlOsVKSoMKvE3WMB7srQbHHnG3L1uKvgkmTr2mbWLiSEaQw5kpheEIbd3jC5T2jfQ
	tFz311A4IVEnWMP6paVtz9jDEyxUBWG40ZLwTM24xJw2Fbalk9wDc//uqnqvmSY/FUzWVfBetri
	aLR9pot/rICcu78hgNlDAJZ4KRmuaPy6ZbXvP1YgCMpD/W8dQPGE51KORa9xFDVkTsyp2S6asiQ
	A1wtczK4rM3j/XxHHbE5YQGuEs6dS+zBTaEcNYDM9Z4S3lhMb6XSvUTpMVrNbjixMg==
X-Received: by 2002:a05:690c:4d41:b0:7f5:b3bf:88e with SMTP id 00721157ae682-806be6eb1b7mr43320207b3.0.1782238484279;
        Tue, 23 Jun 2026 11:14:44 -0700 (PDT)
X-Received: by 2002:a05:690c:4d41:b0:7f5:b3bf:88e with SMTP id 00721157ae682-806be6eb1b7mr43319747b3.0.1782238483619;
        Tue, 23 Jun 2026 11:14:43 -0700 (PDT)
Received: from localhost ([2600:1701:430:16b0::47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80259d20d84sm48252077b3.0.2026.06.23.11.14.43
        for <target-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:14:43 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:14:42 -0500
From: David Teigland <teigland@redhat.com>
To: target-devel@vger.kernel.org
Subject: [BUG] LIO iSCSI target deadlock on PR PREEMPT AND ABORT with
 concurrent I/O
Message-ID: <ajrNEj-B63SDtZ9W@redhat.com>
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1228-lists,target-devel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:target-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[teigland@redhat.com,target-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[teigland@redhat.com,target-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[target-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DED56B965C

Hi, I've been hitting the deadlocked threads copied below while running
some new lvm tests that are doing preempt-abort between VMs sharing an
iscsi target exported by a third VM.  The problem occurs when sg_persist
register triggers udev probing/reads, followed quickly by sg_persist
preempt-abort (preempt without abort doesn't deadlock.)  The combination
of probing reads, and preempt-abort often hits the deadlock.  (I'm leaving
out the more extensive AI analysis and patch which I can't personally
vouch for, but can provide if it's useful.)

An effective work-around for now is calling udevadm settle after register.

Seen on Fedora kernel 6.19.10-300.fc44.x86_64 and a recent 7.1.0-rc.

Thanks,
Dave


  task:iscsi_trx       state:D stack:0     pid:1899  tgid:1899  ppid:2      task_flags:0x208140 flags:0x00080006
  Call Trace:
   <TASK>
   __schedule+0x2b2/0x5d0
   schedule+0x27/0x80
   schedule_timeout+0xdc/0x120
   wait_for_completion+0x9e/0x170
   target_put_cmd_and_wait+0x6e/0xc0 [target_core_mod]
   core_tmr_drain_state_list+0x2eb/0x3f0 [target_core_mod]
   core_tmr_lun_reset+0xa0/0x280 [target_core_mod]
   core_scsi3_pro_preempt+0x7a8/0x8e0 [target_core_mod]
   target_scsi3_emulate_pr_out+0x298/0x3c0 [target_core_mod]
   __target_execute_cmd+0x36/0xd0 [target_core_mod]
   iscsit_execute_cmd+0x279/0x2b0 [iscsi_target_mod]
   iscsit_sequence_cmd+0xf3/0x170 [iscsi_target_mod]
   iscsit_get_immediate_data+0x71/0x190 [iscsi_target_mod]
   iscsit_get_rx_pdu+0xe1/0x300 [iscsi_target_mod]
   iscsi_target_rx_thread+0x8e/0x120 [iscsi_target_mod]
   kthread+0xfa/0x240
   ret_from_fork+0x130/0x1a0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  task:iscsi_ttx       state:D stack:0     pid:1898  tgid:1898  ppid:2      task_flags:0x208040 flags:0x00080002
  Call Trace:
   <TASK>
   __schedule+0x2b2/0x5d0
   schedule+0x27/0x80
   schedule_timeout+0xdc/0x120
   wait_for_completion+0x9e/0x170
   kthread_stop+0x6e/0x190
   iscsit_close_connection+0x49c/0x7a0 [iscsi_target_mod]
   iscsit_take_action_for_connection_exit+0x80/0x140 [iscsi_target_mod]
   iscsi_target_tx_thread+0x162/0x240 [iscsi_target_mod]
   kthread+0xfa/0x240
   ret_from_fork+0x130/0x1a0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  task:iscsi_np        state:D stack:0     pid:1885  tgid:1885  ppid:2      task_flags:0x208040 flags:0x00080002
  Call Trace:
   <TASK>
   __schedule+0x2b2/0x5d0
   schedule+0x27/0x80
   schedule_timeout+0xdc/0x120
   wait_for_completion+0x9e/0x170
   iscsi_check_for_session_reinstatement+0x1f5/0x2d0 [iscsi_target_mod]
   iscsi_target_handle_csg_one+0x114/0x130 [iscsi_target_mod]
   iscsi_target_do_login+0x2d/0xd0 [iscsi_target_mod]
   iscsi_target_start_negotiation+0x67/0x170 [iscsi_target_mod]
   __iscsi_target_login_thread+0x37f/0x7d0 [iscsi_target_mod]
   iscsi_target_login_thread+0x24/0x60 [iscsi_target_mod]
   kthread+0xfa/0x240
   ret_from_fork+0x130/0x1a0
   ret_from_fork_asm+0x1a/0x30
   </TASK>


