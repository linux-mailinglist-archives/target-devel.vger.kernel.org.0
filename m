Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8251E1894CD
	for <lists+target-devel@lfdr.de>; Wed, 18 Mar 2020 05:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgCREPV (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 18 Mar 2020 00:15:21 -0400
Received: from mail-eopbgr690102.outbound.protection.outlook.com ([40.107.69.102]:22756
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgCREPV (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 00:15:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxgpMTbidSEDONCJQ/B4Jw7q8e5Ia0ljaQYA8io9flEXLnB3xCLFljmDEFPW0OwL7imgXM1DN6U+BWwtmcNM0E2fus3yadO7MakSHUrU53UIvXWwdt7uFDG1ZmEJsCgaQ1JyC5d37+5JNmee5JHiKp6BphL0V5C8t3ol7dv6hbnqtJgiufS7YGtxXQ6gBuYmVjtXywdtLBqhKnVb5yf2LMdY5D4ZqfnhFsE6xQM+2RQjJymPFZZKTbvA1KwSvsCMhbJ6ZfxYloLDNLKR3Wf89/CClSXl9qfi9lZg1VpDgJCbahVk3PMQJisHLM2TQOSJBXOjzMbly3etOcoenyT1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u322xx7vlKP6dVXJVfuM/7/BZp6niMEsrJGHtJLkxbQ=;
 b=azSWbE6RlwhcRajN7OJ99wiE1pcUpVGsiITtdkUMI34TKKCF0V5cyxCo1ldCH5NT0sWhe0WmhBv2pu1wE63Hon9CuaZbZzSi86KyXTZnlUgtMgYEpJ4TiLPTS9txlFzqGKgFhduSx+3jXkqv8Z3NstHIkdnBJsU43aJ28nAilbk+gs8R7God3WUEJL0AJuLCPEQiIFk2+kMoy3hiZEwlBTq96TLNz+NAf1t28by0FeWKTLGC7My3uL+TlZ84RpN3jtUBZf9PpnQzgNlIoD0u5RctvEsGOQhO54KHf3OoYYO7lzMynLEkaNZXF60mb1yT45Nfjjn/fkersaJEblDvjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u322xx7vlKP6dVXJVfuM/7/BZp6niMEsrJGHtJLkxbQ=;
 b=UdHb+kZXoDGOCXbW6UzxhxK02XlMeOjbGFWMnkYIbfyR1jZLov2d7Tx+CZfi7suYJ/sCMlW0noKjSc5+u2IM5rh2iTNXosZ0LUl7bfRrqfJH8ftfZMfiUUbrSa1/WBdBXS1GsQlr/pvLpkqB1IT4TLQXmNT7qMLz3TT+0Oftbj8=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Wed, 18 Mar
 2020 04:15:18 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::acd1:24ec:991:f353]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::acd1:24ec:991:f353%5]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 04:15:18 +0000
From:   Rahul Kundu <rahul.kundu@chelsio.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Maurizio Lombardi <mlombard@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ddiss@suse.de" <ddiss@suse.de>,
        "mcoleman@datto.com" <mcoleman@datto.com>,
        Varun Prakash <varun@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: RE: [PATCH 0/3] Fix a race condition in the target driver
Thread-Topic: [PATCH 0/3] Fix a race condition in the target driver
Thread-Index: AQHV+V5exIotBfy5V0eG+enOxiQa+6hNw8FQ
Date:   Wed, 18 Mar 2020 04:15:18 +0000
Message-ID: <DM6PR12MB38681180CFBE0020FF661017EFF70@DM6PR12MB3868.namprd12.prod.outlook.com>
References: <20200313161253.5507-1-mlombard@redhat.com>
 <650e95a9-c055-304c-6f91-4b9f7c046bb4@acm.org>
In-Reply-To: <650e95a9-c055-304c-6f91-4b9f7c046bb4@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rahul.kundu@chelsio.com; 
x-originating-ip: [49.205.220.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cecaaa07-e32d-4fea-7ead-08d7caf2f7d2
x-ms-traffictypediagnostic: DM6PR12MB4498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB449814BC84CF7FBDB509C403EFF70@DM6PR12MB4498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(136003)(376002)(346002)(396003)(199004)(66446008)(66556008)(66476007)(66946007)(64756008)(5660300002)(76116006)(9686003)(55016002)(52536014)(186003)(26005)(44832011)(6506007)(53546011)(86362001)(110136005)(8936002)(316002)(508600001)(4326008)(2906002)(71200400001)(8676002)(81166006)(81156014)(7696005)(54906003)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB4498;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: chelsio.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WRqe/0ggOI4Euqux4G7uRnKfaEc9TEXqOEhJx940GQjMBNTzZ/eQ0OBGS7z33W9HWSBaW4MOc4ilTjdO4t1HiLzHw45vL8KcjlCQjJA4Kb/psrIkrk3sWuc/YWX9bHEOjcO5jkD8UkO0unxk2N7ZlFcgXKOuNGPHzI34DGYkBn/EmqyfdcF0/rYv8tjAB8Aq0tP/BdSUcVdLs1nEk19FXm1IxkYCIXYc4exz+0VA6LFe2t7bvd6GiE4zk3Lh8nZo1BRnmJEeIdijpgOpqFj9xdDsAunZnOssDBianbI3iuFU2Yq7PDNMqwNc9fJieQ7s4An3rxmTB5G2YvX48zDqqC7pjAlRSibpYi86dk3hi5C2w++DXcewSeAQYol/6B0ld8o8JchYtwggCToGeA1IsLOqpC0ozvyZChd6SGnlWLZe2HV6jlIWBtrSAR1Ba7B
x-ms-exchange-antispam-messagedata: 5MD+o8KG6BSsJesNh3u0fLGsSQSHXeWA++BQ64ZVWdFKGoiZRj3bPJAlt7IS1efDsxn7QHQ/AhOTm1yudpgqR/oH43Sxo6X1P+2MJd/950qsU0/2U91d/CNyeM19y/iYUxKIjst7qROkAkEj//NVig==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecaaa07-e32d-4fea-7ead-08d7caf2f7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 04:15:18.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3ZLUT5gETe8McW1sAHfKrY1iph1yrXgmVCorcXJrPW4GFSaTzlF7Qsyp+sjONwYK20IEoYzUvak9Q1Xj36zwymtntwXS8mPAsvsCC7fvaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

SGkgQmFydCwNCg0KUGF0Y2ggc2VyaWVzIGlzIHRlc3RlZCBnb29kLg0KDQpUaGFua3MsDQpSYWh1
bCBLdW5kdS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEJhcnQgVmFuIEFz
c2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPiANClNlbnQ6IEZyaWRheSwgTWFyY2ggMTMsIDIwMjAg
MTE6MDkgUE0NClRvOiBNYXVyaXppbyBMb21iYXJkaSA8bWxvbWJhcmRAcmVkaGF0LmNvbT47IHRh
cmdldC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNv
bTsgZGRpc3NAc3VzZS5kZTsgbWNvbGVtYW5AZGF0dG8uY29tOyBWYXJ1biBQcmFrYXNoIDx2YXJ1
bkBjaGVsc2lvLmNvbT47IFJhaHVsIEt1bmR1IDxyYWh1bC5rdW5kdUBjaGVsc2lvLmNvbT47IE1p
a2UgTWFyY2luaXN6eW4gPG1pa2UubWFyY2luaXN6eW5AaW50ZWwuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSCAwLzNdIEZpeCBhIHJhY2UgY29uZGl0aW9uIGluIHRoZSB0YXJnZXQgZHJpdmVyDQoN
Ck9uIDMvMTMvMjAgOToxMiBBTSwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IE11bHRpcGxl
IHRocmVhZHMgbWF5IHRyeSB0byBkZXN0cm95IHRoZSBzYW1lIGlzY3NpIHNlc3Npb24gc3RydWN0
dXJlIA0KPiBieSBjYWxsaW5nIGlzY3NpdF9jbG9zZV9zZXNzaW9uKCkgYW5kIHRoZW4gZW5kIHVw
IGhhbmdpbmcuDQo+IA0KPiBUaGlzIHBhdGNoc2V0IG1vZGlmaWVzIHRoZSBkcml2ZXIgc28gdGhl
IHNlc3Npb24gc3RydWN0dXJlIGlzIA0KPiBkZXN0cm95ZWQgYnkgaXNjc2l0X2Nsb3NlX2Nvbm5l
Y3Rpb24oKSB3aGVuIHRoZSBsYXN0IGNvbm5lY3Rpb24gZ2V0cyANCj4gY2xvc2VkLCB0aHVzIHBy
ZXZlbnRpbmcgdGhlIHJhY2UgY29uZGl0aW9uLg0KPiANCj4gTWF1cml6aW8gTG9tYmFyZGkgKDMp
Og0KPiAgICB0YXJnZXQ6IHJlbW92ZSBib2lsZXJwbGF0ZSBjb2RlDQo+ICAgIHRhcmdldDogZml4
IHRhcmdldCBoYW5nIHdoZW4gbXVsdGlwbGUgdGhyZWFkcyB0cnkgdG8gZGVzdHJveSB0aGUgc2Ft
ZQ0KPiAgICAgIGlzY3NpIHNlc3Npb24uDQo+ICAgIGlzY3NpIHRhcmdldDogY2FsbGluZyBpc2Nz
aXRfc3RvcF9zZXNzaW9uKCkgaW5zaWRlDQo+ICAgICAgaXNjc2l0X2Nsb3NlX3Nlc3Npb24oKSBo
YXMgbm8gZWZmZWN0DQo+IA0KPiAgIGRyaXZlcnMvdGFyZ2V0L2lzY3NpL2lzY3NpX3RhcmdldC5j
ICAgICAgICAgIHwgODIgKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gICBkcml2ZXJzL3RhcmdldC9p
c2NzaS9pc2NzaV90YXJnZXQuaCAgICAgICAgICB8ICAxIC0NCj4gICBkcml2ZXJzL3RhcmdldC9p
c2NzaS9pc2NzaV90YXJnZXRfY29uZmlnZnMuYyB8ICA1ICstDQo+ICAgZHJpdmVycy90YXJnZXQv
aXNjc2kvaXNjc2lfdGFyZ2V0X2xvZ2luLmMgICAgfCAgNSArLQ0KPiAgIGluY2x1ZGUvdGFyZ2V0
L2lzY3NpL2lzY3NpX3RhcmdldF9jb3JlLmggICAgIHwgIDIgKy0NCj4gICA1IGZpbGVzIGNoYW5n
ZWQsIDMyIGluc2VydGlvbnMoKyksIDYzIGRlbGV0aW9ucygtKQ0KPiANCg0KSGkgTWlrZSwgVmFy
dW4gYW5kIFJhaHVsLA0KDQpUaGlzIHBhdGNoIHNlcmllcyBtYXkgYWZmZWN0IHRoZSBpU0VSIHRh
cmdldCBkcml2ZXIgc28geW91IG1heSB3YW50IHRvIHZlcmlmeSB0aGlzIHBhdGNoIHNlcmllcyBv
biB5b3VyIHRlc3Qgc2V0dXBzLg0KDQpUaGFua3MsDQoNCkJhcnQuDQo=
