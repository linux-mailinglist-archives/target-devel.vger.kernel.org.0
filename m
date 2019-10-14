Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D864D6965
	for <lists+target-devel@lfdr.de>; Mon, 14 Oct 2019 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfJNS35 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 14 Oct 2019 14:29:57 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:50326 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730828AbfJNS35 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1571077794; i=@ts.fujitsu.com;
        bh=hSCd5BrrPr14Nk2q2j3t4e9ygkyElCWpyYzTLVASaRY=;
        h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=F6/D3JLGynzkbEupEtUmzqn4vm6+uyMzqI14DAi7u1b9wB+7nOfx7HIJPIKt6JOZK
         iDHGPSqy4FsWB81qBhGgMav7TqkanffpNIBjcJ4THEgj4vUCB5rLks01VJVb3N3fZl
         eBCzvpYObK8BSLrNNSyF6I5fw5mDurT+JH7TFQpmj5+zQjsfIsPdgrnQjjV+e5Q448
         m92hqXDkEajXhltORX9LrIp7n8dXMh6zooZdPOQNoQtMP7wdOZDPPZLWGlG8UzvKB1
         r4fddl39VBQoPEOM7INNgoE+C4dmLAFwnLGX2LghAwsWeMmuNJNpYEF/sqSuGVdzs+
         /Cit8chY/N/XA==
Received: from [85.158.142.103] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-central-1.aws.symcld.net id 53/71-25221-2AEB4AD5; Mon, 14 Oct 2019 18:29:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsViZ8MxRXfOviW
  xBqsWaFhM+/CT2WLPoklMFuuPbGC0aF36lsmBxePyFW+P9/uusnlsPl3t8XmTXABLFGtmXlJ+
  RQJrxtYZm9gKvnBXzD/xjbGB8TxnFyMXh5DALEaJjo5tLF2MnBxsAgYSKybdB7OFBUwkpp36z
  ghiiwg4Spy6+xrMZhYok1h/aS07iM0LEn85mxXEZhFQlfh38S8ziC0qEC7xYssfVogaQYmTM5
  +wQPSaSczb/JAZwhaXuPVkPhOELS+x/e0c5gmMPLOQtMxC0jILScssJC0LGFlWMVomFWWmZ5T
  kJmbm6BoaGOgaGhrrAkkTI73EKt1EvdRS3eTUvJKiRKCsXmJ5sV5xZW5yTopeXmrJJkZguKYU
  MvTtYHwy643eIUZJDiYlUd6YjYtihfiS8lMqMxKLM+KLSnNSiw8xynBwKEnw1uxdEiskWJSan
  lqRlpkDjB2YtAQHj5II7wKQNG9xQWJucWY6ROoUo6KUOK8MSEIAJJFRmgfXBovXS4yyUsK8jA
  wMDEI8BalFuZklqPKvGMU5GJWEeVVApvBk5pXATX8FtJgJaHGg/mKQxSWJCCmpBiajH01Bjq8
  5209l/Z1nd0eb94Lg1xY5rl5XqydqcQe2PhJeYL7GKnLK5drLJ1iYdmx7t3fXnR8PH09s3HVC
  //mLAr/gQlfup/3zLHXjdfjdFLOSWZPuH7uwSWguZ3XYzIz8cwKfJ/hurfe/riZ2lctpxevST
  9K7LzUzvk7NrvDmdZnCvUDb3ejk6rMO5x68uGeeoWt0Ym+D/WNLxgVWXNv/t+XuqXOdPlMowC
  Ng2R0R3alh/+Xb06wljopOEA6QrQ7Qc+icoKa+PkM0LyfRbbVMzfUbG73Dzk3JenUw/WKZ6QF
  GrjbeA+pTdEJzbr/Iu6P0c+EGgUvXdwrIvo0wCZhabrXk1JPnT0yOyp4TEVZiKc5INNRiLipO
  BAAyMxoOUgMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-31.tower-228.messagelabs.com!1571077771!167900!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19065 invoked from network); 14 Oct 2019 18:29:42 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-31.tower-228.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Oct 2019 18:29:42 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id x9EIT9ZR012671;
        Mon, 14 Oct 2019 19:29:10 +0100
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Subject: [PATCH] target: do not overwrite CDB byte 1
To:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Message-ID: <12498eab-76fd-eaad-1316-c2827badb76a@ts.fujitsu.com>
Date:   Mon, 14 Oct 2019 20:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

passthrough_parse_cdb() - used by TCMU and PSCSI - attepts to
reset the LUN field of SCSI-2 CDBs (bits 5,6,7 of byte 1).
The current code is wrong, as for newer commands not having the
LUN field it overwrites relevant command bits (e.g. for SECURITY
PROTOCOL IN / OUT)
We think this code was unnecessary from the beginning or at least
it is no longer useful. So we remove it entirely.

Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
---
  drivers/target/target_core_device.c |   21 ---------------------
  1 file changed, 21 deletions(-)

--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -1075,27 +1075,6 @@ passthrough_parse_cdb(struct se_cmd *cmd
  	unsigned int size;
   	/*
-	 * Clear a lun set in the cdb if the initiator talking to use spoke
-	 * and old standards version, as we can't assume the underlying device
-	 * won't choke up on it.
-	 */
-	switch (cdb[0]) {
-	case READ_10: /* SBC - RDProtect */
-	case READ_12: /* SBC - RDProtect */
-	case READ_16: /* SBC - RDProtect */
-	case SEND_DIAGNOSTIC: /* SPC - SELF-TEST Code */
-	case VERIFY: /* SBC - VRProtect */
-	case VERIFY_16: /* SBC - VRProtect */
-	case WRITE_VERIFY: /* SBC - VRProtect */
-	case WRITE_VERIFY_12: /* SBC - VRProtect */
-	case MAINTENANCE_IN: /* SPC - Parameter Data Format for SA RTPG */
-		break;
-	default:
-		cdb[1] &= 0x1f; /* clear logical unit number */
-		break;
-	}
-
-	/*
  	 * For REPORT LUNS we always need to emulate the response, for everything
  	 * else, pass it up.
  	 */
