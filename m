Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0AF189C79
	for <lists+target-devel@lfdr.de>; Wed, 18 Mar 2020 14:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgCRNCn (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 18 Mar 2020 09:02:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:63757 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgCRNCn (ORCPT <rfc822;target-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:02:43 -0400
IronPort-SDR: V/E/B7/RGp7BgN3royZarzsG/A6Cw84Qw4ffXTd08keLS2AoxVTCLjqSjyEjQzaKcRO2ngg1O9
 2+VRx4ow0Fqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 06:02:42 -0700
IronPort-SDR: ZmlbMQAgplrEJ4XiV0hb1hK3BzBigIUWjpsSgvM2dSJPHXis5oIyJUlRgzqvW9FVoJB2iSAYPL
 wQfqmbh3t4zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,567,1574150400"; 
   d="scan'208";a="279728296"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga002.fm.intel.com with ESMTP; 18 Mar 2020 06:02:39 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 06:02:39 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Mar 2020 06:02:38 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Mar 2020 06:02:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 18 Mar 2020 06:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeAmvMLl+5r21/u2Y6dAXHn0j60jq3A0fB6BtQiIh3/UNTnO44Y5tw5rF5Y3bWaLCMJzWbuF9lU8M9p3znZNtAyj0lxBLBDwJ+7V5yplKnpO7j3zbYbd+J/OXhjunh7PIIMZThkbjgMORwAYMoGrPTclfXLEYBNYmGXlRjMbLcbTaEnZMlGJMtIeYJO2mNoH+xBw2mEyiPBpWP6Iw+oGh3pnSHd0MZGm8hDe+GS9XnUoNL0TM9jZkP6RgNDXYlrFiN510/O+6mxG/0ct1TTMPVcgbINPXNxxzwVUnpVWJqUgj+JxcC2lmsDw0d3vzDvg6eyvHpDQ06/ddF548OQQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prbpWl95taqQVOE7aFj4PR6z6D5PTW0z8Q6o9RTYn4o=;
 b=KJSOtpVjJ5utNQl+C0ocN/47+3QbZe3TFuAFyVTfu5s9EixaD5Si3lENEp2JkeNvxSGI5LG1QSfHpmCyHpvw/rqPQa1hvQJ8proHOvT2k1ZGcVK8lRwpZrLZfR1GSm1GIE0LyQlr9lRmX3jefYpdEx8GvD/eAPMWlhv9Vbry3jgSllMwaHBmKQEvDj/7mFWjz36Hi8f1/RqVjQWCMEOvGUmoKYRSBIpGTlAGLDCBRlaxAdsVVcsgOUZxNdPisHgtL8clnCo0i14lYgV5ce6e5Yn/nN8NROoNuGYMJErhv2G/T7fGeW2uX0qZiUodJzDgKLMaTIfVHdNzgfP+SalLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prbpWl95taqQVOE7aFj4PR6z6D5PTW0z8Q6o9RTYn4o=;
 b=MgfVrXG6hgpBqXQjnZD1NE0Xt9y2kLfxPaYPC5TQUXTkxxyT5zg0Jb8IYKHVymYJxd8cLW0gYilsVpX46kQXfyHbKV4Yot08lY9HhF1qfXZDst5svgjmgnWs2sXCRJOtbtmGCB81847DbW4ny2cW0vF0gNA+uq5REmxBMYBh7wM=
Received: from BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19)
 by BY5PR11MB4008.namprd11.prod.outlook.com (2603:10b6:a03:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Wed, 18 Mar
 2020 13:02:30 +0000
Received: from BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::dcc8:671c:82b1:5ba3]) by BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::dcc8:671c:82b1:5ba3%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 13:02:30 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Rahul Kundu <rahul.kundu@chelsio.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Maurizio Lombardi <mlombard@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
CC:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ddiss@suse.de" <ddiss@suse.de>,
        "mcoleman@datto.com" <mcoleman@datto.com>,
        Varun Prakash <varun@chelsio.com>
Subject: RE: [PATCH 0/3] Fix a race condition in the target driver
Thread-Topic: [PATCH 0/3] Fix a race condition in the target driver
Thread-Index: AQHV+V5ykft/i+tcpUmmPUVcsnC/pKhNxO0AgACSc/A=
Date:   Wed, 18 Mar 2020 13:02:30 +0000
Message-ID: <BY5PR11MB395886DF1D01983EAEA1501386F70@BY5PR11MB3958.namprd11.prod.outlook.com>
References: <20200313161253.5507-1-mlombard@redhat.com>
 <650e95a9-c055-304c-6f91-4b9f7c046bb4@acm.org>
 <DM6PR12MB38681180CFBE0020FF661017EFF70@DM6PR12MB3868.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB38681180CFBE0020FF661017EFF70@DM6PR12MB3868.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [134.134.136.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1d1ea74-2255-42b0-1805-08d7cb3c9de2
x-ms-traffictypediagnostic: BY5PR11MB4008:
x-microsoft-antispam-prvs: <BY5PR11MB400876920B273F7ED52AC7BA86F70@BY5PR11MB4008.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(2906002)(86362001)(54906003)(110136005)(316002)(33656002)(6506007)(7696005)(8936002)(8676002)(81156014)(81166006)(478600001)(558084003)(66946007)(66476007)(5660300002)(76116006)(66556008)(64756008)(52536014)(66446008)(71200400001)(4326008)(26005)(186003)(9686003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR11MB4008;H:BY5PR11MB3958.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9di/eFl+S1JXhYkZKvgfbAAPCQtts5ENzIoFpwc0stUOt3av6vqKxHUlzK9+WSCeVY7j4eqJx6Pu8t2yGybe9LxDOw5lOj42iQkR75xYoCFkzu6DGSSdqR6eoIQA2pZgnP/N3ML15qYXvRTn6msYAy8Y9V8jLsTL1GEak/Se0JhWsFlmZYjNqJtxxFarwZ1Uos+Nl1mdfG9b1CC09hfzvAWSxX7IoeWKTBsf5fnZfkVqfD6SFABW7kDKQtCtdljgtRoHACxDFCe1egRTiR2RpL2oBlNlMj6uboIT5b4L5j749IOojc0IEEBuCvM2P9ImuQtypPw80ObNE8ysF/fZEGjmhY/dHuDCYX4wXyjos0a6LfrDz3l6vADODivCVQy/WLqQzOsPSXhBMFuFKrP7rgl/bVkMUwyZEt5pULJsYPIv5/s8V1AHAnDjy10EOlh
x-ms-exchange-antispam-messagedata: +DpocKiiwAIIZJwHV9UKxJ6sUZJBlZdxt+RTkG2Y/dqmlyxQEGzA2qNagM44Lj8F99rJRuIcwzr2V2afQtCyuUNEWIfEtFExCWnwo7ZlaB29zUULlvpsAYLvVOYC2WN+RojJJHI2dtK0exa9L7+x/A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d1ea74-2255-42b0-1805-08d7cb3c9de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 13:02:30.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCmdRBewLCaFne6XV/Te/THj4djtvqzoLnmLRvvw61VH5dTcRNXzSAzOEtrGcn4OHb1NB/GpgmV9U21I+IORujccV5NiUOUfktKxQgdqXOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4008
X-OriginatorOrg: intel.com
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

PiBIaSBNaWtlLCBWYXJ1biBhbmQgUmFodWwsDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBtYXkg
YWZmZWN0IHRoZSBpU0VSIHRhcmdldCBkcml2ZXIgc28geW91IG1heSB3YW50IHRvIHZlcmlmeQ0K
PiB0aGlzIHBhdGNoIHNlcmllcyBvbiB5b3VyIHRlc3Qgc2V0dXBzLg0KPiANCj4gVGhhbmtzLA0K
PiANCj4gQmFydC4NCg0KV2hhdCBpcyB0aGUgYmFzZSBmb3IgdGhpcyBzZXJpZXMuDQoNCkkgY2Fu
IGVhc2lseSB0ZXN0Lg0KDQpNaWtlDQo=
