Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E964EB8F8
	for <lists+target-devel@lfdr.de>; Wed, 30 Mar 2022 05:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiC3Dlv (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 29 Mar 2022 23:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiC3Dlt (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:41:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D481BEA5;
        Tue, 29 Mar 2022 20:40:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3TIqG011958;
        Wed, 30 Mar 2022 03:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BZ5wrQJmhRm7pUhZ2/lbDXC1AS4pNgbgAR6GtMKmScQ=;
 b=cny7VpxuT2PLEMo0raF5jYcKRtjEXd3WFen5X/bE+ZaA9zBLpwcC+GCvcFPwJZyNSFnm
 RCgOEFM9eM4h66Hk0SNzoGhTZHjeTNS/yzp4btWYFVs/MU8QbUj0zOF/XOk6uImrHIod
 7qEDQZLsWm+KlK185maZBXGRoeIn89x2pUYDs7cr9uXZ+U3QAxRGG8XywxjyIbaXipbY
 1DKCzYaZRgnrFGQ4SQSNtRUXA8YaBnOVo34angy3/uRIRbTyxUoNiwb8bx3USnu3b9Tt
 KlvpkISpEC2/bd7E8iVjrLI6xyXEJd2t2VSw42I2qvKBKoyTWVsnRberPejWediiJQpi ig== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2gand-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:39:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U3cSC5143449;
        Wed, 30 Mar 2022 03:39:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by aserp3030.oracle.com with ESMTP id 3f1rv8e847-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+gYsfpD7/KUFDqQGhD6f0jc4FpmlDaf0fyJMk9cHZMVAr+5u6wWl/MFVwdLa+k49Zx9fMf6OLMhcekWyL/GsHiamb8vspdrZer8NIGGm52x4tjfX7HMQ0sMZigxAM9Ngq/bKU6R1Dgti9pNOFCvu53eJiK4dpKGDdgrnq+YQeetpdkm6N/mGbfRZ3dRZqqDeg6/kM35cWbSvw+5D/88go4FdrcU6MmsNtOIrCA+o83g0mYGaUmVWHsl12OiEMRa6E8V7a5hQZsTC4WoKgSVv7BW7aw3ZOLXLu3ICL+ndCssd51JOX2NIBbQxG6y7cwLSpjExukr4XziJsNpp4qABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ5wrQJmhRm7pUhZ2/lbDXC1AS4pNgbgAR6GtMKmScQ=;
 b=QeF3TcOKCt8QFAxJoex9fkaeH3Em2badYfYft9WjKmO1PsF1CE2LUlLpx7SJ+JF8qzfGxQDZ/yAgys5hvoA3bL0QpFXSqe0768LR6BnTH32mSqv2oIexV2Q6W88g0ByEBPGFHZmogrvSBKenNVf4v9SMa9+9cLKZbuG7Oa4wibsoH53B9NuwMpLd6oQqqZjFds00iD8J3lI95ug7Q+wfJXk+nJFrt3xarS3lVAMUvO1IRf7FWyG5a/VQwp+IalW061J1slUvzmPIrNGXvlpBO8mN4AObPPO7j+aweXVbTtJtViwNrmhb57UQWIYoHseCn6WxnMTU94IPbudROztedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ5wrQJmhRm7pUhZ2/lbDXC1AS4pNgbgAR6GtMKmScQ=;
 b=wgebKcVdwIexWVEa2SFb5vVjrvDAkuK0clg83kQNT/MojJdPlNiC5x2BSwmo6LRf22XopJ4X7fbVeEJ8p6RgrlG7/97LkX3st+2hY5bHNmcBfjC8hTXjEYWTcznKTWXCkIjtR/43/7iSdItvD7m+oB+6IGTPMtmWfwsjvEbnMYw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN6PR10MB2767.namprd10.prod.outlook.com (2603:10b6:805:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Wed, 30 Mar
 2022 03:39:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:39:48 +0000
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        brking@linux.ibm.com, target-devel@vger.kernel.org,
        mikecyr@linux.ibm.com
Subject: Re: [PATCH] ibmvscsis: increase INITIAL_SRP_LIMIT to 1024
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmm4un0o.fsf@ca-mkp.ca.oracle.com>
References: <20220322194443.678433-1-tyreld@linux.ibm.com>
Date:   Tue, 29 Mar 2022 23:39:46 -0400
In-Reply-To: <20220322194443.678433-1-tyreld@linux.ibm.com> (Tyrel Datwyler's
        message of "Tue, 22 Mar 2022 12:44:43 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aca99771-b7c1-46c4-2041-08da11fef067
X-MS-TrafficTypeDiagnostic: SN6PR10MB2767:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2767888BCD6A68C2C598F21D8E1F9@SN6PR10MB2767.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4viTBhDSJn26PDKYHBE35k08DEVdLT0dA6NSnW8vCCeSdH1ZTxjVom1r+3Y4N6oiP2Mp8JYb5d7mmiKwrtLdQD5vHE27pMa3FVxt/EwSpdIJQF9JT4juSFNUf7zK3vYTAdYBhDuS1NfrQEyJvrsWQ76NcfQ738qZw23TY/ldL7qu53UVJKa+31wBXNi0v7ICFZSQbCPzuWbCkG5Xqxb3SZkXXrocgngBaK41VYZ2G/2+dXlSJxeaLY9dlXEnYcRDNTrH5Ew+Zjh9e1DY+jhFXJnDJKghwUzHHY7VsZTMK6iPTRDUQVMVaGO9ST9paFM1rcXg5UE1XpHHsLCDRJtF0OWBhXkUzUvggBj0QTNayGft5WI5bcaBupgdIzgFWyTi69sXFtPlj9S3WOop7m8YZzD4P7Tly4flv/K0y6CiV1Sv9rtRiMqs/jUhufFXX+IaEAccAU6M1ALwz1cI32V4831cBOK0gaGaCP6nE0O/wj86BGZsEuzIgxgavcwtJW/b17RSjNvR6K+wA+SKjB1XVK+Fv/E6huUrHW30iEJ2LFju+F6J8m77iaLJzfKt97fbkOxtUmzPyh1Gd0n5e/Wsu5QOnsdZ/m20avLbi4EQyDDCdY0hhLcJjPycV3bR3Fp12rhjj32JLAJMTSoOdMNmgjWxua826uG7M8UggnTUJ/btNXl0zM6QSsCcaT8bPWqxY0YsIwy6OASM1YfVxIcFmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(36916002)(8676002)(52116002)(4326008)(83380400001)(6512007)(66946007)(66476007)(6916009)(6506007)(38100700002)(38350700002)(316002)(5660300002)(26005)(186003)(66556008)(6486002)(508600001)(2906002)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q1StYqZ5lt5GKW0HR7g+E94+NQIluIegK7UwFZihO/zxLeBTuIGh/4A9cJiM?=
 =?us-ascii?Q?j2/v+/85MfSYtyU5CC0zMHghfqXMuM7g5VFbXnEg+ln3F5Qli3lxePuCnv7T?=
 =?us-ascii?Q?/osGU3H4SgDEUCa3gmEXXwGh7CwS4UyA1RhccSp8GG5ml3t9tUDVS9hyMBph?=
 =?us-ascii?Q?/ezkEpJ6pdmETc5vEJdYlPZWmEQKHhlPWFzLPp8cwbEHb/LCMTGish4OUpyr?=
 =?us-ascii?Q?u5sttKlbyTOKfDYonl4ggctpL52vVctidvAmhzFqaaYeEoEPZobgsZmb2zvi?=
 =?us-ascii?Q?Kin0g2qKMVJbWiS5oquZYiubM/y0p1OHy0ZwbTHlBz1xegr3v9aPRy3L8MJK?=
 =?us-ascii?Q?6e8EjyL/c4UcEEtzliXD/zszjr+D0ASe0a1+Mc0M3PFWT3w0yRASjUeH7akf?=
 =?us-ascii?Q?3yWi8OcsXAlObHHybd6zUrCuJWjnPTn/gWaFmCggMun2x4KtUD+56iXaWfDz?=
 =?us-ascii?Q?xRohT40y0KQPKHHfmWCY2qGU6dBc6i0oW4POZKqc02azIvd1BxALobM+Znd5?=
 =?us-ascii?Q?GMYm0ZJuThaXcYuYhlsH2yBrPJOcqXfNDJpHPalox6FrIs3CH1hfbh2A7GPJ?=
 =?us-ascii?Q?isYds2gMWXvBDSFMqcqKHL58netDID/Ao2ULMEQOEWf74V1crMqV7B+QN9XQ?=
 =?us-ascii?Q?gU1c3PaJ2RGP2ezwm/PBaFOCdp371YKMCyWqraqWjHq6IjQ6anmfssanPIVG?=
 =?us-ascii?Q?bFkZIa+L4MyXKmQq4CSPNA4EA3MNQl0jD91pNcyZwe0PYqoOYkVNYp/+86CI?=
 =?us-ascii?Q?WiCr+aSrNaBPkCzdSvrZVxvn5F07cViiuTBBkD/bZQ0iJ9oeAiUNqLHa0I4W?=
 =?us-ascii?Q?TlFgltn7vSi+AQGRDHEm+LSEl6cZATSQQkH3D2bZyZGmCdMdurE6yjzCrhO0?=
 =?us-ascii?Q?Ip+QLOpILHdcxrkFKWrDe25k83aWZsnrn+4RGeClHra2fBNFRMH2prTt0cGZ?=
 =?us-ascii?Q?dRbgsm7KKJP9WGvNP34G87n4zzMwttbCxLQN2GcdVW0F5HZsLDB8J/Bl/TA0?=
 =?us-ascii?Q?v8BhUTRVMMPjleji9vPXc0ZLhyw58lbam6MgfmqXN9Z8LhYlBUSieWNo7Szf?=
 =?us-ascii?Q?gAOUS+QuQmcmp6Vp1t0ZNTx31WM3n1UYOc+r1RNixVF65eRbv+xIET/xSHcF?=
 =?us-ascii?Q?BjXe4DnW+c53rijjXAItXCyGyB212QBScIO5oT/vOZpj35uUfq6kDa3JgwNq?=
 =?us-ascii?Q?b5c0VKhTJP9f2s+3FPJD9dGUBvaP8tFj6/JoE7aBpwbPa1v2GI/YGvxIu+jz?=
 =?us-ascii?Q?EoyfQxpzJbhCatHkbGyimaUZhaodX6yUiKBBc37mCeCx5Xxy1rzpnZuMOfkF?=
 =?us-ascii?Q?iXdJfotPePP8Qo/RUEJkBzJ/Jy0DlCywsm+pPZrkmPqSMxwifJZBhxMpWhA3?=
 =?us-ascii?Q?S5+mKHlpwOmpf3wJ+u1dA3djScrHwDnkfCoPEv7OcHZRqnrGM+34GYlaDoHi?=
 =?us-ascii?Q?QFwdsZqOVed/FFpy3hQp17qlA1NAUVxhumDAI/IIvZSYmpdGdz43+CU0f7KG?=
 =?us-ascii?Q?jjyO64rkisCKAMmh9lKMY3qAsBq8OssAMTNjAZV8IUu4EvoovNzyxlMIveWc?=
 =?us-ascii?Q?Ax7G10y6MsRuX2+BPEyODnC/83pVaLqmANFN8GN8Il0d3TMGKFzth+O7/6Fm?=
 =?us-ascii?Q?FWE1oFqOWjzhBQURoKRNVDwQGUZe+s2W9BFT2/HFLFeRxhdGr0stU/4gPzDc?=
 =?us-ascii?Q?0/bu0z8h391+RIv5UsJxaguiVJgBzh1r+Zr70aL+LGmAzifooWfn3Wm/+yVR?=
 =?us-ascii?Q?cZ0SxttohrUme5WFYxiRL2NyXZX0nSw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca99771-b7c1-46c4-2041-08da11fef067
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:39:48.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFKhUxcaxfxKfvTDaSDlIyz6spXFhc9kn6HWQVKq2S4wmo7rDtoxRQgaqtO7rJvMgLtnqe1a5UYRxvWBQHEvG3Gb7IpksuP8x6yJfZzL8pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2767
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300015
X-Proofpoint-ORIG-GUID: TTGHKzS-9UX-TFvxEqtsAtfDK3ZAkq0q
X-Proofpoint-GUID: TTGHKzS-9UX-TFvxEqtsAtfDK3ZAkq0q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


Tyrel,

> The adapter request_limit is hardcoded to be INITIAL_SRP_LIMIT which
> is currently an arbitrary value of 800. Increase this value to 1024
> which better matches the characteristics of the typical IBMi Initiator
> that supports 32 LUNs and a queue depth of 32.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
