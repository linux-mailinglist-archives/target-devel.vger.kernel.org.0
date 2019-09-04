Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13817A96B6
	for <lists+target-devel@lfdr.de>; Thu,  5 Sep 2019 00:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfIDWtO (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 4 Sep 2019 18:49:14 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:60689 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbfIDWtO (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:49:14 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Wed,  4 Sep 2019 22:43:46 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 4 Sep 2019 22:49:09 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 4 Sep 2019 22:49:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOG7Ev0uFM0BSc9LtjtR+laY0Kx09f12xSmtnipHQYVhmdDbKRLpCtCqGQDFK+gI9N57QaaKnrcD2Va6RnO54YeW65POhb/ppFS4o2ksKzdpeSHee/luYakHUCCqgb2oFP08g0eypUgchkXD3eojsNkvvwe2ZtFv91Hokj/FwROEAz9F7E78U3X6S0FCF+HBA22UC7xQfJjHDkKlExkc2+dk53h7YoRMHvzAyRtdKi7qVxA6fkpsd/ZHuvbRxW1zuBWwRA77iM934la8EAZVUkRBEI1/3UkpgfmAOkVxSuqZAmw0BeIJIYE7pintZf7YhNgU2VeZ1y7Djxsz3ITN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDfOz8D5jbc3pI8QWnCE3EOjYkkhQHzhiIq2Q6wwAdE=;
 b=A+Ub+qIVzpzmqKT4dnMBGX+wFOPxTmX/lSGCTx/dp8GdyII8tDHU2quAmajLs9JDsl9a2pEk0RlwFY+rO+ewnne3rKKTCGCgoM9PTrxZHIM6Xwnn3pfq+3GJiBc/5iRNidccBjJp7X/js3T0dXmrBghx28N2NAaJ2917akAuPenhEVEf+OHCFPiq7g7mh7tbUS0nLiU3/xys5emdWmAZaGyZrheuvA3k/CJ4s51AXgbPu2RZoK26DMy9l7DpOXcn9x9bQKrbYloAxbfM0HyXR5E7cupunRgFLgC+1jhrf7OQgxFVVEkBVfIHM1CqIPxceuWQt9ZQGpbR0ER/ot15HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BN6PR18MB1172.namprd18.prod.outlook.com (10.172.207.147) by
 BN6PR18MB1140.namprd18.prod.outlook.com (10.173.149.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Wed, 4 Sep 2019 22:49:03 +0000
Received: from BN6PR18MB1172.namprd18.prod.outlook.com
 ([fe80::4cf:874f:61a4:e220]) by BN6PR18MB1172.namprd18.prod.outlook.com
 ([fe80::4cf:874f:61a4:e220%9]) with mapi id 15.20.2220.021; Wed, 4 Sep 2019
 22:49:03 +0000
From:   Lee Duncan <LDuncan@suse.com>
To:     David Disseldorp <ddiss@suse.de>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
CC:     "mchristi@redhat.com" <mchristi@redhat.com>,
        "mlombard@redhat.com" <mlombard@redhat.com>
Subject: Re: [PATCH] target: compare full CHAP_A Algorithm strings
Thread-Topic: [PATCH] target: compare full CHAP_A Algorithm strings
Thread-Index: AQHVX1a4Ap9igJe1zku3bqybT9SYDKccJy6A
Date:   Wed, 4 Sep 2019 22:49:02 +0000
Message-ID: <1cfbec10-1a07-d535-1100-fee4fdfa206b@suse.com>
References: <20190830171611.32540-1-ddiss@suse.de>
In-Reply-To: <20190830171611.32540-1-ddiss@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB7PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:10:52::35) To BN6PR18MB1172.namprd18.prod.outlook.com
 (2603:10b6:404:eb::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=LDuncan@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [73.25.22.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d13338c-aa9c-43ef-d484-08d7318a153c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR18MB1140;
x-ms-traffictypediagnostic: BN6PR18MB1140:
x-microsoft-antispam-prvs: <BN6PR18MB1140DFB22754DBB62A4FF5BBDAB80@BN6PR18MB1140.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(316002)(52116002)(54906003)(6512007)(478600001)(2906002)(6116002)(6436002)(76176011)(229853002)(26005)(53546011)(81166006)(81156014)(66946007)(6506007)(6246003)(31686004)(6486002)(66066001)(110136005)(386003)(53936002)(186003)(102836004)(3846002)(8936002)(99286004)(80792005)(2616005)(25786009)(446003)(256004)(305945005)(11346002)(71200400001)(71190400001)(36756003)(14444005)(66476007)(66556008)(64756008)(66446008)(4326008)(86362001)(31696002)(2501003)(476003)(486006)(5660300002)(14454004)(8676002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR18MB1140;H:BN6PR18MB1172.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZWxP3QuF17QSr3MAEDDAEEwMq1FFyC59cQ8EA8cngCSWqhoQAjYSYG0IBKPIHfWdiCHWVaCjG9MK/GyVT9bKGvmCz606pxpGxO27u4oXpi5DDWd8Lxi493qL9UihJe+Vofw/Bz3tTQGH9mrAy/VNQ8DtrFVSJ2sW7KGaDPlwnOAJURINkUW34QIhsIaCeXv3lUOjzS+fiGhPZu62pLVFusdsOQVdWdgFzNtNFjdMHkIQ+Jyg2qnSirRzQ8IpQd8nppG+PCsf1vwj/1DVwnB2xxPd6wBYBrDL/Di/ggaDhjuwqDWm/qoWcnOYaztqK/aFNgPRd2YQ2JXn/YVrAW6COI6rodhUiugIw72iX7KXGT9JBviVIvm5yDDdR0+eozrItJaUl5SXr3VdrDEF2PTkfcCnTOOPK/ubCxjxJ5s0f9s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D72CEC9BB411274EB864D2D63FE3BCE0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d13338c-aa9c-43ef-d484-08d7318a153c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 22:49:02.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmn+UQml9QfsqYA6aWlK2M9kOhEC4E7wT770hLS7edLwbZoeVj/Mlh61u3Nv/UfRBgLKFO7Zv97BExLtIGzlQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR18MB1140
X-OriginatorOrg: suse.com
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

T24gOC8zMC8xOSAxMDoxNiBBTSwgRGF2aWQgRGlzc2VsZG9ycCB3cm90ZToNCj4gUkZDIDIzMDcg
c3RhdGVzOg0KPiANCj4gICBGb3IgQ0hBUCBbUkZDMTk5NF0sIGluIHRoZSBmaXJzdCBzdGVwLCB0
aGUgaW5pdGlhdG9yIE1VU1Qgc2VuZDoNCj4gDQo+ICAgICAgIENIQVBfQT08QTEsQTIuLi4+DQo+
IA0KPiAgICBXaGVyZSBBMSxBMi4uLiBhcmUgcHJvcG9zZWQgYWxnb3JpdGhtcywgaW4gb3JkZXIg
b2YgcHJlZmVyZW5jZS4NCj4gLi4uDQo+ICAgIEZvciB0aGUgQWxnb3JpdGhtLCBhcyBzdGF0ZWQg
aW4gW1JGQzE5OTRdLCBvbmUgdmFsdWUgaXMgcmVxdWlyZWQgdG8NCj4gICAgYmUgaW1wbGVtZW50
ZWQ6DQo+IA0KPiAgICAgICAgNSAgICAgKENIQVAgd2l0aCBNRDUpDQo+IA0KPiBMSU8gY3VycmVu
dGx5IGNoZWNrcyBmb3IgdGhpcyB2YWx1ZSBieSBvbmx5IGNvbXBhcmluZyBhIHNpbmdsZSBieXRl
IGluDQo+IHRoZSB0b2tlbml6ZWQgQWxnb3JpdGhtIHN0cmluZywgd2hpY2ggbWVhbnMgdGhhdCBh
bnkgdmFsdWUgc3RhcnRpbmcgd2l0aA0KPiBhICc1JyAoZS5nLiAiNTUiKSBpcyBpbnRlcnByZXRl
ZCBhcyAiQ0hBUCB3aXRoIE1ENSIuIEZpeCB0aGlzIGJ5DQo+IGNvbXBhcmluZyB0aGUgZW50aXJl
IHRva2VuaXplZCBzdHJpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBEaXNzZWxkb3Jw
IDxkZGlzc0BzdXNlLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvdGFyZ2V0L2lzY3NpL2lzY3NpX3Rh
cmdldF9hdXRoLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RhcmdldC9pc2NzaS9pc2Nz
aV90YXJnZXRfYXV0aC5jIGIvZHJpdmVycy90YXJnZXQvaXNjc2kvaXNjc2lfdGFyZ2V0X2F1dGgu
Yw0KPiBpbmRleCA1MWRkY2EyMDMzZTAuLjhmZTliMTJhMDdhNCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy90YXJnZXQvaXNjc2kvaXNjc2lfdGFyZ2V0X2F1dGguYw0KPiArKysgYi9kcml2ZXJzL3Rh
cmdldC9pc2NzaS9pc2NzaV90YXJnZXRfYXV0aC5jDQo+IEBAIC03MCw3ICs3MCw3IEBAIHN0YXRp
YyBpbnQgY2hhcF9jaGVja19hbGdvcml0aG0oY29uc3QgY2hhciAqYV9zdHIpDQo+ICAJCWlmICgh
dG9rZW4pDQo+ICAJCQlnb3RvIG91dDsNCj4gIA0KPiAtCQlpZiAoIXN0cm5jbXAodG9rZW4sICI1
IiwgMSkpIHsNCj4gKwkJaWYgKCFzdHJjbXAodG9rZW4sICI1IikpIHsNCj4gIAkJCXByX2RlYnVn
KCJTZWxlY3RlZCBNRDUgQWxnb3JpdGhtXG4iKTsNCj4gIAkJCWtmcmVlKG9yaWcpOw0KPiAgCQkJ
cmV0dXJuIENIQVBfRElHRVNUX01ENTsNCj4gDQoNClJldmlld2VkLWJ5OiBMZWUgRHVuY2FuIDxs
ZHVuY2FuQHN1c2UuY29tPg0K
