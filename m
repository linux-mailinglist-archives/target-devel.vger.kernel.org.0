Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7511E3AD6B4
	for <lists+target-devel@lfdr.de>; Sat, 19 Jun 2021 04:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhFSCda (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 18 Jun 2021 22:33:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6498 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhFSCd3 (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 18 Jun 2021 22:33:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15J2Cd9L006396;
        Sat, 19 Jun 2021 02:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=/oTwWFfX51XLmaOxfGG+86Gow/z281XkZWthgblE0zw=;
 b=Ueu+Ag8ffJG3/AgtQMyhkqUaPPLi6WoGcM4qFKD9fn5XBplIpzR9rh21HBpdmMulU1fp
 yxWICCrN92WQSfo4Nl7cQ0/rJC4I943AG2C+TbSE3yzP1gQe0/jgLOEfKV7q2RQj6cjB
 lSIi+kDsVn9i5DRM/ssAolKmkgGDYNuv1dMYUjqtufZMjRcSrK7vbOAamr3pb8Ykxbz9
 qCm2Lry/F6MKb561q5LBbwd+RjhcNkMOMFr2BV7cdepPILbIYKKCVvzCapIpWahMhaGI
 Cr4NMb/MfHYiaqb8og7w/4FU5Dc7q0PZGKc2FDdJ37DiukYzQQDgT+a6Z61LUuQWE4k6 wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 398xmp0qam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Jun 2021 02:31:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15J2FFZd148584;
        Sat, 19 Jun 2021 02:31:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by aserp3020.oracle.com with ESMTP id 396wb02qd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Jun 2021 02:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqB2O3F6QYFCTQPZi3SW8GsG4l+xWcOfnUBSq8VHwm3xsBsfImX2n1MNjWAbqqXuIBdTiCNUz3psybaPTiMzOOArmPc+J8RZZA8lUgndNhcH+tbe+Ju1tEezc8I22Li6RGBtPO1L1vpfEJttuHgqHV4QsCBNk6WRabREfBTdHkKVEAvHzRNqHrO699Tb6QUso6hjGhokqLKNoWn0vaGytNLRdR+iSqtpSy2uSSvTTaE/ArCLqTLLT+yzIrjEee5nuzBG7itD01FMfeYY0lBstXyyAbVzqoxLhWvUdUJDUsCHmD+PvnTIWbiR9K3Jv/VP15JHYJlHX/N/KbvCV7tmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oTwWFfX51XLmaOxfGG+86Gow/z281XkZWthgblE0zw=;
 b=NAOWBcq7t8EtM6XinmKsoyWrbK/Qq8H3Em2lmX4iZQaNeJDI8NYqbHVlDxpkHBjCdkt1jQQQoxvQQKO2KF+ZWdg0suCwgh9yD4noWdnksjad4mIrm3s/vTD5+dqlIYEDKMyWKQ4Qhw+ThUdLCMN1oDXs1RElv7VPgLO/2ujPIKGFU0ECIkH4HWXwJY4V2Ec3vVKSo4BXtgCGNOmiBCqTu4kBo07RC+9qXjE9o076NSc8+dErd5q2QVVbQwgyfIp+QBFcGvHPId+9skd1V35A9eksu66zy0OGP327v/fMFPiOk+WBT1GKrOfrCTiv+Dca6kFiTzlvdCrMnmpvDbkGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oTwWFfX51XLmaOxfGG+86Gow/z281XkZWthgblE0zw=;
 b=xdC4xq9QT4mp76acFLlKvgE1mgkd0MOLMI5ZJMlPjchcxD8roPKvniiI5KRPTFO8eqMOxwtWDNNxZ2pR5NPnjvAWNHZddNHbiHm3puoxvg1FDV8ZuQbBHz04pnSyh6ksFZmmr0L0D9vPvSM758/jXf+wB/kf3DUam5nlCqpZlpw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Sat, 19 Jun
 2021 02:31:10 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::4c61:9532:4af0:8796%7]) with mapi id 15.20.4242.022; Sat, 19 Jun 2021
 02:31:09 +0000
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] scsi: elx: efct: Do not use id uninitialized in
 efct_lio_setup_session()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135teziu4.fsf@ca-mkp.ca.oracle.com>
References: <20210617061721.2405511-1-nathan@kernel.org>
Date:   Fri, 18 Jun 2021 22:31:05 -0400
In-Reply-To: <20210617061721.2405511-1-nathan@kernel.org> (Nathan Chancellor's
        message of "Wed, 16 Jun 2021 23:17:21 -0700")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SN4PR0501CA0115.namprd05.prod.outlook.com
 (2603:10b6:803:42::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SN4PR0501CA0115.namprd05.prod.outlook.com (2603:10b6:803:42::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Sat, 19 Jun 2021 02:31:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d39442c-4bfe-4b8d-9d10-08d932ca4c72
X-MS-TrafficTypeDiagnostic: PH0PR10MB4533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB453341B0E062AF1C3248CDA48E0C9@PH0PR10MB4533.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFb4J7+ZNdnfnt7SEkwdbsI4evi+ekAVo5pkIvm9b2m8O5Iqz0uLj5PJvfzZW5aruwgoVT3DnrdSgbe0tQBDnsXN9lffJbbTcq75Q8CpZ31rzWfFpGKZAnkwWKwRTkIn4NTNojRAtK94cI6OoxbVHItuUH7Qc3CZbj3sCV+UKirXCtPePsjWu4QQ1NNUvy0bwpaWmyTQCF04Z1cQ0ec7Yorw0ie9PDNerMMkmjDvOtbjNxk07bgLJBIFZZZTB+vWYmLfxO0FRka+gGodqWwiIGBwj+bAHglcFlo3HspnVtIFWRttfddILvh9KfBKCqou1shFdzGho48U1vX68pB/p22S8tP4HMfoTPgNMYaAJ0EykJkMwQYtsDKS6O8FlnToxzrg7cDeX+QWQEBou7U9NooGwi9cASxDpBxMDvjxnaS3Q7QAHC6VX/1QsAz9eTHh6iCH2xR8sxxycFIYegGMvYJHlnQX9SNTH15PBQpU3Zh0zW263bhUuOv6WwAsjJhRZpPqZu4CgqqouAxH56zEqJYM5Alzu2L4/93nLkONzp/TLoakQNl9l9w34WBJd0+ClDEj9AcbpmJ34QXUZgD01+0AJl6FBAOWny3ndjlZE9w0qLZFfja6L/5na2vWHVzPx6qM6m1khUMh4rwaySBXgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(6916009)(8936002)(86362001)(478600001)(5660300002)(8676002)(54906003)(4744005)(52116002)(6666004)(36916002)(38100700002)(55016002)(26005)(38350700002)(4326008)(2906002)(316002)(956004)(83380400001)(186003)(66556008)(7696005)(66946007)(16526019)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bcLd3ChoQ8NFLQuFFRS5pk0ZGQA5N+267HaaUM3aFTeksuYob3rCXlBTcDRR?=
 =?us-ascii?Q?O1CajGY/Npt1+Bv2l4RiCGsWWU9VXMLDgeL3F3wpxNK5krIs4AiBXDdBv5yz?=
 =?us-ascii?Q?uaSyiULSquARGJhQuYcb42SzK2rFoVJhCBe3+54NOoZ9dLGuMmPX3jC9MIcn?=
 =?us-ascii?Q?QT01FBHq2Zqw5L7lVa2Y6+BX6+QD3aHrynjGjhDmKIUkWZ3x/6DJM6pAq6aC?=
 =?us-ascii?Q?LrWJv/7RAppN99tQeNJPsjMZtqGliqESHuvQ5xyM0wOQa/v51pMrK8m/z+tc?=
 =?us-ascii?Q?Z6vcICQqJOPJPfGEXScIJ7KHX64QkxdwYaHF4Wu5Y8koA60qQuapxL/tKmaL?=
 =?us-ascii?Q?76k1NlFmndpq0w5wM1BQ27F2pZ8pE2CxdEcl8JhxoayGqwIvTwDccgAd1E00?=
 =?us-ascii?Q?5hRl4+VGelA0AherIy9VEOiBiyMhrUa76iaUXzrJTDhEga4lJEKWoE12nj09?=
 =?us-ascii?Q?19vbqQESaeYyaEKlVqB59QCto1IFOHCoBscfZveWv9slbJGvrrwsbiaSj8Wx?=
 =?us-ascii?Q?uyHpWT/N+s7QGMP3G+0g8PUwm9/ClZ0QtZZbEXSj5N6+ip5v44OhFeDWB3XC?=
 =?us-ascii?Q?dy4UMOl2p3m/dUek5sGKNrAqf+y0DxMHDLSlT3cJzzytZ/QyYqonTIUfaV4j?=
 =?us-ascii?Q?+OFH4ZkDfm0//4NK6P5+nChxJB8vM3PYZVuv6h6pRmDWWdLE4GC2sWQFs8Xn?=
 =?us-ascii?Q?4Fcz5tdeeUyT7J51+Bhu55Ssn4V2HcqIEiIeV6udK44Gji6cPr4XcAlGa84v?=
 =?us-ascii?Q?AFrblMlgO3k0AXD631DzsZ3iiUbZ4d4SITh1jiwhs72I2jspnmB1UbbuG40G?=
 =?us-ascii?Q?FIAJJV/W7CinUI0NVoqRMz7TiRhTpfl3vJi6NRQeWwUqqTvEhVFK26D4zh8z?=
 =?us-ascii?Q?q/e127E1bFhFR9K0DXO7oprLEV1j0alzHV6aeO3Db2KyOOzXgT2FiRh+p+nE?=
 =?us-ascii?Q?cS24NjuYM3si31NfM5vgXzu157p4JjmKxzTBaVc6LJlc05zgKQod951zW6X4?=
 =?us-ascii?Q?Ht4CxgRzDOHpHnG3FWeUdFxBH9yMtZ2FzMFIaZzgP4/T2wzo4U/zpx2HlGlC?=
 =?us-ascii?Q?DAT80QgiwLVzYMKZ0YFyMadjnIeGVmpZmovk20obTXiq8ONGhOMyDmqLV8r/?=
 =?us-ascii?Q?1pLrT/ZIRz8KQJvknUgHM/1j2+FcDlJgbzBBWEQ3eJK39KKwE8kw28rrsXBd?=
 =?us-ascii?Q?aP/G0rqaZqgeqOmfGNflqDrh2+EMlcwB2n0ET8xIf2/Yl1xUexWnkKr37wC6?=
 =?us-ascii?Q?zfX4CZ1/MYdYqUVOpcWSilaW17qS8LLD3G/3KIMjOhb+pQyAqb+dpbcdoN5K?=
 =?us-ascii?Q?9Ut+9gq704s1ZAMYK1We0jqV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d39442c-4bfe-4b8d-9d10-08d932ca4c72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2021 02:31:09.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsbLfKRMyN0gAxAc/mQZ0sRCTC7haCvqWa3f5c3MPjegSvWmjMqrHUrPRmz8eujnNPSD9eLPPfgcugkVLdSNwQyRDAKbL3Ef66Jhoo5gowU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10019 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106190010
X-Proofpoint-ORIG-GUID: MzRfG5uIABFLUH1ghSCk78ohhFYlPPev
X-Proofpoint-GUID: MzRfG5uIABFLUH1ghSCk78ohhFYlPPev
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Nathan,

> clang warns:
>
> drivers/scsi/elx/efct/efct_lio.c:1216:24: warning: variable 'id' is
> uninitialized when used here [-Wuninitialized]
>                       se_sess, node, id);
>                                      ^~
>
> Shuffle the debug print after id's initialization so that the actual
> value is printed.

Applied to 5.14/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
