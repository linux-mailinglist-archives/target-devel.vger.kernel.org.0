Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D051462120D
	for <lists+target-devel@lfdr.de>; Tue,  8 Nov 2022 14:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiKHNNi (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 8 Nov 2022 08:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiKHNNh (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:13:37 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7AA454
        for <target-devel@vger.kernel.org>; Tue,  8 Nov 2022 05:13:34 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so2034165oop.3
        for <target-devel@vger.kernel.org>; Tue, 08 Nov 2022 05:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=qDywU1/m1/avxgKPvPUVc1zJrc7utt+ugpYIk/HLSUow8wM5BQrFpKsw/NJ8I/M4C8
         yFkdp0eQ2ol4lCFLB3cW3+4su1Yfo4aNsXPNoEqjzfBKfATyyUbxkC1iovTTL7zUZYP7
         xtg4wgtgcPv1Yv10BW12eG7IHTdvQYz0p20MlJvfrLFEZes0CceMBiRTb1DQw7EfiVUv
         DuHRQ+1QvByf9mUUIUjlpCajha+f4ZxnmZ2PCQscGv/wa1J5LFX6OvZ7na8ZGxTyk3n9
         sOiV7CbewU/eEHs79J1295yF2j/Ro8JSI4cMwymHf5mXyscHT3dhHS8hMp4IAksmqL0G
         atoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=Fyw6vQ9D0CaR+HfGbH3MH7ReYbDIKIApduqnG5f89p468l9MvTR2BoL3HXdekT23tj
         z6NUrI6rP3xb8WRw7mv5MWQs61MsIpcWzhAvLYxe2OKh6y57bRw2HTza7Wz7dJ/nh3cE
         CAaEzVnsAV4sgWevsqb/De0xILMdBzt3fhcxlpH+Ir5jgUAuwKrQFsa0t3K6zpUIQdSr
         zRfcmRRDFmlu4b6faexlXYOkVJN/LmPU0v4AKdddk12neZmmg1ZfQAUBOOxLEn/mVyjG
         0cN2WKOE5KoOutf4dfe8/SA8rsPq2rVKefR+a8ymrvYEjGIOqXpOvlMmcs+qvhlKZYBY
         yI2A==
X-Gm-Message-State: ACrzQf1SKhnKLga69ilQaqjhSCPVXFdhaioPtoGznNY1KoYxz0PjEnu4
        +JMZCBVlziXt22PTvuYAA2Tag4NDqWiGJUaXj+g=
X-Google-Smtp-Source: AMsMyM7cDWdD+h09szB6NYUUVooaP5RKVzpiGvU5el8Z4Wn8ExOZydpS1wbymHFYRnhfMLtdZ43sKlX/ipN/pL4t/yY=
X-Received: by 2002:a4a:9847:0:b0:481:12f3:bd3e with SMTP id
 z7-20020a4a9847000000b0048112f3bd3emr23549241ooi.26.1667913213766; Tue, 08
 Nov 2022 05:13:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6802:1a2:0:0:0:0 with HTTP; Tue, 8 Nov 2022 05:13:33
 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <mrdavidkekeli@gmail.com>
Date:   Tue, 8 Nov 2022 13:13:33 +0000
Message-ID: <CAMqe2pAcnGQJcqW3QWiaFuWoy5PJ2wjTSt-mgxCFgdPpQmLA8Q@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
