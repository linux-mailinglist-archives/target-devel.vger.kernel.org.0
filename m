Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D97D020B
	for <lists+target-devel@lfdr.de>; Tue,  8 Oct 2019 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfJHUUT (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 8 Oct 2019 16:20:19 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:40727 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbfJHUUS (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1570566015; i=@ts.fujitsu.com;
        bh=78uPEKUEOadX+e1OkbXD2/8K1blmereSmu+ST01Bplo=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=DvRvby+V6lncBy1KSkDicQCU2QIGiEVBVQgI0fz/hPcCP+YtvCNo8GF2xf9dNtQ/Q
         08FpTfF5OoE4ZuWE6qPMglnekmx3UA/qWC6yxqGIqBTvGJhZSXeXW4qugjEoKEf5/0
         mqgbZFIUTE8XjCD1pgBeqh0wDJWm3D7hzQeG4OyzzJ8SkRlY8y0p74Cii+xpMOOkM8
         gJ2L0PkArM/HalIVk2rh/HCF1Hyn6P0Sr264LBvBT3TcSbATv6XB8zNDj4QSSGebzQ
         6O3f2sIW/SFfGlzxihK1bK1YHcqYAmZGo7pli2A3RyOXZ3I+lOYdhP8dl18jOdZu8S
         4vp8keIL/D4JQ==
Received: from [46.226.52.199] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 35/66-04297-F7FEC9D5; Tue, 08 Oct 2019 20:20:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRWlGSWpSXmKPExsViZ8MxVbfu/Zx
  YgyVz9S3WH9nAaNG69C2TA5PH+31X2Tw+b5ILYIpizcxLyq9IYM34sPcsa8Ffvoq255/ZGhhf
  cHUxcnEICbQwSfzrn8kO4RxllPhxexkThHOGUeLdlnaWLkZODjYBV4mW5Y8YQRIiAu2MEsfmd
  rKCJIQFbCROPTwHViQi4Cjx9cZFKFtPomfBdWYQm0VARWLy7QZ2EJtXwF+ia+0lsF5GAVmJL4
  2rwWqYBcQlNj37DhaXEBCQWLLnPDOELSrx8vE/qLiBxNal+1ggbAWJq3u3s0D06kncmDqFDcL
  Wlli28DUzxC5BiZMzn7BMYBSehWTFLCQts5C0zELSsoCRZRWjRVJRZnpGSW5iZo6uoYGBrqGh
  ka6hpbmuobGBXmKVbpJeaqlueWpxia6hXmJ5sV5xZW5yTopeXmrJJkZg3KQUHG3awdhz5LXeI
  UZJDiYlUV6Ty3NihfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwCr0DygkWpaanVqRl5gBjGCYtwc
  GjJMJrApLmLS5IzC3OTIdInWK055jwcu4iZo6dR+cByYNgsvH57sXMQix5+XmpUuK8694CtQm
  AtGWU5sENhaWcS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeZNBpvBk5pXA7X4FdBYT0Fn5
  LrNBzipJREhJNTCtORG7u+yRutmjb33+AQ0/JsguFlttvPv0iSnpyiwLLm760N1/umT/MvXk2
  wvXioRNDLz+d65Hyb6kC57fP11y3n3zTumv7+2iiw+xvvE6WPMy8LmcCFfh64tNV6Ild4s2vj
  Jj4k9Pt7qbuX8N/8kFJaYfaytapnJwuvncLvP8GBUt1iwZrpgY/JNPovbuq9DtB1lVdfVfvvn
  5/7qFnmai4t/sLGPpvk0p6qp7BQKliz8e3CP3JmadnYmca+TK8sMXQzI+ZcoYSSdlyyuvKBJs
  vp/RfqMgo0D+tJHYB5VX83jmlU3TVUqbLjvHu8Nfzm5TQvKTq7a+EVOefPvF6/Z5pe2swA1bH
  b9xhy0qXKfEUpyRaKjFXFScCAD7m72OtAMAAA==
X-Env-Sender: bodo.stroesser@ts.fujitsu.com
X-Msg-Ref: server-18.tower-287.messagelabs.com!1570566013!176256!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7347 invoked from network); 8 Oct 2019 20:20:14 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-18.tower-287.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Oct 2019 20:20:14 -0000
Received: from R01UKEXCASM121.r01.fujitsu.local (ex2k13_121.fs.fujitsu.com [10.183.43.173])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id x98KKDrx016820
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 8 Oct 2019 21:20:13 +0100
Received: from R01UKEXCASM125.r01.fujitsu.local (10.183.43.177) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Tue, 8 Oct 2019 21:20:12 +0100
Received: from R01UKEXCASM125.r01.fujitsu.local ([fe80::39fc:a7b:1dd:1341]) by
 R01UKEXCASM125.r01.fujitsu.local ([fe80::39fc:a7b:1dd:1341%23]) with mapi id
 15.00.1473.003; Tue, 8 Oct 2019 21:20:12 +0100
From:   "bodo.stroesser@ts.fujitsu.com" <bodo.stroesser@ts.fujitsu.com>
To:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Mike Christie (mchristi@redhat.com)" <mchristi@redhat.com>
Subject: Wrong resetting of Logical Unit Number field in CDB
Thread-Topic: Wrong resetting of Logical Unit Number field in CDB
Thread-Index: AdV+ErJiFiD5bW47T/a1O2arOy/zoQ==
Date:   Tue, 8 Oct 2019 20:20:12 +0000
Message-ID: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
Accept-Language: en-GB, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.183.43.93]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,

We use TCMUser to run userspace tape and changer emulations.

Current tests with a new version of backup SW failed, due to that applicati=
on
using SECURITY PROTOCOL IN / OUT  SCSI commands.
The CDBs of these commands in byte 1 contain relevant information that
is overwritten in passthrough_parse_cdb() / target_core_device.c

This is the related part of the code:

        /*
         * Clear a lun set in the cdb if the initiator talking to use spoke
         * and old standards version, as we can't assume the underlying dev=
ice
         * won't choke up on it.
         */
        switch (cdb[0]) {
        case READ_10: /* SBC - RDProtect */
        case READ_12: /* SBC - RDProtect */
        case READ_16: /* SBC - RDProtect */
        case SEND_DIAGNOSTIC: /* SPC - SELF-TEST Code */
        case VERIFY: /* SBC - VRProtect */
        case VERIFY_16: /* SBC - VRProtect */
        case WRITE_VERIFY: /* SBC - VRProtect */
        case WRITE_VERIFY_12: /* SBC - VRProtect */
        case MAINTENANCE_IN: /* SPC - Parameter Data Format for SA RTPG */
                break;
        default:
                cdb[1] &=3D 0x1f; /* clear logical unit number */
                break;
        }

Obviously the list of command codes for which bits 5,6,7 of byte 1 are _not=
_ reset
is not complete. Now I'm wondering what would be the right fix:

1) Scan the SCSI specs and add all other missing command codes to the list =
of
   Codes to skip

2) Create a list of commands that definitely have the LUN field in byte 1 a=
nd
   reset the bits only in those. (Might be better than 1), because I expect=
 new
   commands to not have the LUN field.)

3) Remove the code entirely, because it is no longer needed / useful (?)

For 1) and 2) an additionally question is, based on what SCSI version the l=
ists would
have to be created?

Based on your help and hints I'd like to create a patch.

Thank you,
Bodo




