Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE434666A
	for <lists+target-devel@lfdr.de>; Tue, 23 Mar 2021 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhCWRbf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+target-devel@lfdr.de>); Tue, 23 Mar 2021 13:31:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:27386 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhCWRbG (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:31:06 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-174-n-noPgEzM7y86OSuRImITA-1; Tue, 23 Mar 2021 17:24:10 +0000
X-MC-Unique: n-noPgEzM7y86OSuRImITA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 23 Mar 2021 17:24:10 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 23 Mar 2021 17:24:09 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>, Arnd Bergmann <arnd@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Chaitanya Kulkarni" <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "Bodo Stroesser" <bstroesser@ts.fujitsu.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] target: pscsi: avoid Wempty-body warning
Thread-Topic: [PATCH] target: pscsi: avoid Wempty-body warning
Thread-Index: AQHXHzg8Ec1w7xHA2UmLjcXmQJO77qqR0oNQ
Date:   Tue, 23 Mar 2021 17:24:09 +0000
Message-ID: <9f16a764ac564866b6ba6fad4c00b67a@AcuMS.aculab.com>
References: <20210322114441.3479365-1-arnd@kernel.org>
 <20210322154735.GA2079192@infradead.org> <20210322155344.GA23040@1wt.eu>
 <CAK8P3a1bb4QvNyM9kkt0KB9k70cdEZ-e+B-CHHtPhaPO6ouxeQ@mail.gmail.com>
 <20210322162601.GB23467@1wt.eu>
In-Reply-To: <20210322162601.GB23467@1wt.eu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

..
> I totally agree with this one but usually it's already reported by
> another one (probably the one complaining about misindenting). The
> case I've seen quite a few times was:
> 
>      while (condition);
> 
> At least I want the ';' on its own line to avoid it being
> confused with one that ends a do {} while() block.

For that one it is worth doing:
	while (condition)
		continue;

I've also managed to write:
	while (...) {
		....
	} while (...);

And if anyone thing code should be laid out as:
	do
	{
		...
	}
	while (...);
Show them:
		...
	}
	while (.......................................................
	{
		...
and ask them what it is supposed to be.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

