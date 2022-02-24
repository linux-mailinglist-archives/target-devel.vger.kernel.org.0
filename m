Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714194C341F
	for <lists+target-devel@lfdr.de>; Thu, 24 Feb 2022 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiBXR40 (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Feb 2022 12:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiBXR40 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:56:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA7279446;
        Thu, 24 Feb 2022 09:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XZX3UmbaQkDmJFjkktEWq0Jff43NC5jY/7i2VYvYlPc=; b=1kXGefjjv3TDvSDI/65Xj27dcK
        6UYAjGj1+J6ckx7HV/1Uo0L9WP4bqaxrSriCZGeku1PKL1ndcxkPWX7id4nRSiDaOJM1Hz7w/bCo1
        fRJJSkNLEd+b47SAUIaSTpbLTYKaHTlQthwXICGe1pPfqlGdnnGrQYGnOoz+uOne5FGcqr4r5XXdA
        Ubmqbe3J3Ju0dpq6Mudb1RQWFRkBmImi1jv/bEjlJAvtPalXW//Eo7dW5tMLW1vIFbaECKWCXDRGw
        aJ/y1ydoDILiUeq4j6rK7RvVHSe0+ULz2Z/cWEFCPd4iNMd4KZenkJJJt5PearIite07JkAYQrtkR
        AH032lbg==;
Received: from 089144202139.atnat0011.highway.a1.net ([89.144.202.139] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNILL-001uPk-0o; Thu, 24 Feb 2022 17:55:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: remove struct scsi_request v2
Date:   Thu, 24 Feb 2022 18:55:44 +0100
Message-Id: <20220224175552.988286-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi Martin,

with the recent removal of the REQ_OP_SCSI_{IN,OUT} based passthrough
from non-scsi drivers, the need for the scsi_request structure went
away as well.  As all submitters of SCSI passthrough requests are using
the SCSI midlayer now they can just fill out the scsi_cmnd directly.

Changes since v1:
 - fix a few commit message typos
 - remove an extra clearing of scmd->flags
 - cleanup sense handling in sg_scsi_ioctl
 - split the last patch

Diffstat:
 b/drivers/ata/libata-scsi.c           |    4 -
 b/drivers/block/pktcdvd.c             |    8 +-
 b/drivers/cdrom/cdrom.c               |    1 
 b/drivers/scsi/scsi_bsg.c             |   42 +++++-------
 b/drivers/scsi/scsi_debugfs.c         |    6 -
 b/drivers/scsi/scsi_error.c           |   38 +++++-----
 b/drivers/scsi/scsi_ioctl.c           |   76 +++++++++------------
 b/drivers/scsi/scsi_lib.c             |  118 +++++++++++++---------------------
 b/drivers/scsi/scsi_logging.c         |    5 -
 b/drivers/scsi/scsi_transport_sas.c   |    1 
 b/drivers/scsi/sd.c                   |   28 --------
 b/drivers/scsi/sg.c                   |   44 ++++--------
 b/drivers/scsi/sr.c                   |   30 ++++----
 b/drivers/scsi/st.c                   |   30 ++++----
 b/drivers/scsi/ufs/ufshpb.c           |   22 ++----
 b/drivers/target/target_core_pscsi.c  |   67 +++++++------------
 b/drivers/target/target_core_pscsi.h  |    4 -
 b/drivers/usb/storage/cypress_atacb.c |    1 
 b/drivers/usb/storage/isd200.c        |    4 -
 b/include/linux/bsg-lib.h             |    1 
 b/include/scsi/scsi_cmnd.h            |   16 +---
 b/include/scsi/scsi_eh.h              |    4 -
 include/scsi/scsi_request.h           |   31 --------
 23 files changed, 224 insertions(+), 357 deletions(-)
