Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12F6186BCD
	for <lists+target-devel@lfdr.de>; Mon, 16 Mar 2020 14:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgCPNHW (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 16 Mar 2020 09:07:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45055 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbgCPNHW (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:07:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id w4so3835415lji.11
        for <target-devel@vger.kernel.org>; Mon, 16 Mar 2020 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=vucUpYLnwVjaNVZurSRlrnvn2Nz6FZACq2hs44k4s/8=;
        b=YfES1RQ7AmpLh8D/I1reoRf6udm2XDkfF7005PDlEc+CBYZy1eIR5dKWxv2YDw5Ihc
         mqACoWx/5jGrWuRpuRFmfkijTR+6wbdlixadTSj7+M2tnWfoVL8DH3SqpgYjGq4mJ5UA
         OQwAJ956UztX4N3UYFWY08b38jYgVsWlwASkU870z55Q/ygC1ugwIp4JvkMSy8wxZfh3
         vGcbc2tSFRa/Y6sKiozWhTlvj9M36ic00dbw6IIMH+ygvRZmkbE9ahWigBK7XAb1UbzH
         EsgfaOa/BVKQqaNe3pc39qYpzs2llyFhoi4jRTJ5FOALKeF6StlYWtq8vSlmYwDDzKQ0
         lLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=vucUpYLnwVjaNVZurSRlrnvn2Nz6FZACq2hs44k4s/8=;
        b=G01o64FKper5efAVJoD4DLXON+jAifBD8BfaNzUo365rU+/oBKFbGK7jHAH0zN5vRl
         P+3QF5+EfMADmuRNtwLM/dmiytQdyTzyXM5h5Irp8vVyePedQ6U1BIyFa6W6f6ZH4vMH
         fVHmWW3P0JoK95m1sO8X9yK40vkw3I9cwnVW2YMvLZkUwezlplPyhhTVZLbxfPLTO7lp
         DWb+IlAMABCKjK+jq82oomsTDPXEA+YirEOG6fP/o+Mcka/lvAFDpQzo94Rxeaf9K46t
         22yxUDrdrc/HSbK6AunjrEzKXZ/r9gNMlwUOhirriHCbrukfDxH9FfrWQ+MygxGkMYGL
         3hMg==
X-Gm-Message-State: ANhLgQ2jOWnyiR4TiqaeFhiPRE9ngmiNu9yz+GvctZuK1/2GQf5vco9g
        5sTDz7ivXHuyg1oolCsBDZEVIYnH4Hl2LP+Dzaw=
X-Google-Smtp-Source: ADFU+vu0z5c65tRd5gxfPoNGlxkjnWPEs7IavV5m24S05CdSCbKzMX1PbqgcyH0a/3jrWNX/o+qPkA==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr14549875ljg.144.1584364039851;
        Mon, 16 Mar 2020 06:07:19 -0700 (PDT)
Received: from vdubeyko-laptop ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id l205sm981943lfd.50.2020.03.16.06.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 06:07:19 -0700 (PDT)
Message-ID: <226e01deaa9baf46d6ff3b8698bc9fe881f7dfc1.camel@dubeyko.com>
Subject: [PATCH] scsi: target: core: add task tag to trace events
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, linux@yadro.com, v.dubeiko@yadro.com,
        rostedt@goodmis.org, mingo@redhat.com, r.bolshakov@yadro.com,
        k.shelekhin@yadro.com
Date:   Mon, 16 Mar 2020 16:07:17 +0300
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

From: Viacheslav Dubeyko <v.dubeiko@yadro.com>
Date: Tue, 10 Mar 2020 17:04:41 +0300
Subject: [PATCH] scsi: target: core: add task tag to trace events

Trace events target_sequencer_start and target_cmd_complete
(include/trace/events/target.h) are ready to show NAA identifier,
LUN ID, and many other important command details in the system log:

TP_printk("%s -> LUN %03u %s data_length %6u  CDB %s  (TA:%s C:%02x)",

However, it's still hard to identify command on the initiator
and command on the target in the real life output of system log.
For that purpose SCSI provides a command identifier or
task tag (term used in previous standards). This patch adds
tag ID in the system log's output:

TP_printk("%s -> LUN %03u tag %#llx %s data_length %6u  CDB %s  (TA:%s C:%02x)",

kworker/1:1-35    [001] ....  1392.989452: target_sequencer_start:
naa.5001405ec1ba6364 -> LUN 001 tag 0x1
SERVICE_ACTION_IN_16 data_length     32
CDB 9e 10 00 00 00 00 00 00 00 00 00 00 00 20 00 00  (TA:SIMPLE C:00)

kworker/1:1-35    [001] ....  1392.989456: target_cmd_complete:
naa.5001405ec1ba6364 <- LUN 001 tag 0x1 status GOOD (sense len 0) 
SERVICE_ACTION_IN_16 data_length     32
CDB 9e 10 00 00 00 00 00 00 00 00 00 00 00 20 00 00  (TA:SIMPLE C:00)

Signed-off-by: Viacheslav Dubeyko <v.dubeiko@yadro.com>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>

diff --git a/include/trace/events/target.h b/include/trace/events/target.h
index 50fea660c0f8..7f4525d12aeb 100644
--- a/include/trace/events/target.h
+++ b/include/trace/events/target.h
@@ -136,6 +136,7 @@ TRACE_EVENT(target_sequencer_start,
 
 	TP_STRUCT__entry(
 		__field( unsigned int,	unpacked_lun	)
+		__field( unsigned long long,	tag	)
 		__field( unsigned int,	opcode		)
 		__field( unsigned int,	data_length	)
 		__field( unsigned int,	task_attribute  )
@@ -145,6 +146,7 @@ TRACE_EVENT(target_sequencer_start,
 
 	TP_fast_assign(
 		__entry->unpacked_lun	= cmd->orig_fe_lun;
+		__entry->tag		= cmd->tag;
 		__entry->opcode		= cmd->t_task_cdb[0];
 		__entry->data_length	= cmd->data_length;
 		__entry->task_attribute	= cmd->sam_task_attr;
@@ -152,9 +154,9 @@ TRACE_EVENT(target_sequencer_start,
 		__assign_str(initiator, cmd->se_sess->se_node_acl->initiatorname);
 	),
 
-	TP_printk("%s -> LUN %03u %s data_length %6u  CDB %s  (TA:%s C:%02x)",
+	TP_printk("%s -> LUN %03u tag %#llx %s data_length %6u  CDB %s  (TA:%s C:%02x)",
 		  __get_str(initiator), __entry->unpacked_lun,
-		  show_opcode_name(__entry->opcode),
+		  __entry->tag, show_opcode_name(__entry->opcode),
 		  __entry->data_length, __print_hex(__entry->cdb, 16),
 		  show_task_attribute_name(__entry->task_attribute),
 		  scsi_command_size(__entry->cdb) <= 16 ?
@@ -171,6 +173,7 @@ TRACE_EVENT(target_cmd_complete,
 
 	TP_STRUCT__entry(
 		__field( unsigned int,	unpacked_lun	)
+		__field( unsigned long long,	tag	)
 		__field( unsigned int,	opcode		)
 		__field( unsigned int,	data_length	)
 		__field( unsigned int,	task_attribute  )
@@ -183,6 +186,7 @@ TRACE_EVENT(target_cmd_complete,
 
 	TP_fast_assign(
 		__entry->unpacked_lun	= cmd->orig_fe_lun;
+		__entry->tag		= cmd->tag;
 		__entry->opcode		= cmd->t_task_cdb[0];
 		__entry->data_length	= cmd->data_length;
 		__entry->task_attribute	= cmd->sam_task_attr;
@@ -194,8 +198,9 @@ TRACE_EVENT(target_cmd_complete,
 		__assign_str(initiator, cmd->se_sess->se_node_acl->initiatorname);
 	),
 
-	TP_printk("%s <- LUN %03u status %s (sense len %d%s%s)  %s data_length %6u  CDB %s  (TA:%s C:%02x)",
+	TP_printk("%s <- LUN %03u tag %#llx status %s (sense len %d%s%s)  %s data_length %6u  CDB %s  (TA:%s C:%02x)",
 		  __get_str(initiator), __entry->unpacked_lun,
+		  __entry->tag,
 		  show_scsi_status_name(__entry->scsi_status),
 		  __entry->sense_length, __entry->sense_length ? " / " : "",
 		  __print_hex(__entry->sense_data, __entry->sense_length),
-- 
2.17.1


