Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209DA1B1250
	for <lists+target-devel@lfdr.de>; Mon, 20 Apr 2020 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgDTQzb (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Mon, 20 Apr 2020 12:55:31 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:52080 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgDTQza (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1587401726; i=@ts.fujitsu.com;
        bh=ud36Imv9jHFKOb7iKcdzDdn+kdT83Hkd06VUVtPqd/U=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=t7IVnzXwk6V+gDkFRZTL/N/yBJzJCDqtxDIMQXGYA3qoDZJ5akXIbfEr8xlXwuS5i
         fRb7XNrNPu8jtCHaMps1SeFG6CALggnMw8xSBogX/IF1SQFbKsevjjn+u9KQtIhEuT
         OdcZm2WcJJiliPy8YHaeCrjx8bPoyTwikmNKTI9lky/CQpkC1oQ9w9tVCs4NgFdXKo
         tw13VMrSCc4vRpc8yI3O3bbzCyMTp7WLZiyfbpsFiKHLcoQNU5wGaHLAye20Bh0Gxu
         PUmDG0UUExqJR4Fb3CCGQ8Nfv6G3jcsN0Wzt9tTHr++OilqqQx9wIcXFlBKcmmBYcO
         NkvFpDMcZMZsw==
Received: from [100.112.198.136] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id C8/CD-46636-EF3DD9E5; Mon, 20 Apr 2020 16:55:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRWlGSWpSXmKPExsViZ8MRqvvv8tw
  4g+d/JSyWH//HZLH+yAZGi9alb5kcmD0+Pr3F4vF+31U2j8+b5AKYo1gz85LyKxJYM2a+vMle
  0MZZMe3MT6YGxvXsXYxcHEICsxgllsy7z9LFyMkhLGAj8fr+JHYQW0TAVeLIxXOsIDazgJzE7
  uWvwGwhgViJ50+nMoLYbAIGEismQfTyCjhK9M/eCxZnEVCVmHfqJxuILSoQLvFiyx9WiBpBiZ
  Mzn4DVcwpoSTy5vowNYr6txJ25u5khbHGJW0/mM0HY8hLb385hnsDINwtJ+ywkLbOQtMxC0rK
  AkWUVo0VSUWZ6RkluYmaOrqGBga6hoZGuoaWFrqGFiV5ilW6SXmqpbnlqcYmuoV5iebFecWVu
  ck6KXl5qySZGYDCnFBzbsYPxyPL3eocYJTmYlER5+1LmxgnxJeWnVGYkFmfEF5XmpBYfYpTh4
  FCS4D15CSgnWJSanlqRlpkDjCyYtAQHj5IIbyBImre4IDG3ODMdInWKUVFKnHcdSEIAJJFRmg
  fXBovmS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeY2BqUGIJzOvBG76K6DFTECL801ngyw
  uSURISTUw1QT/bsp8ap0tGZv777W//KSu6s55K5TWe/5VXfYtYV5N4PF24bD4/llvchc7Jkkf
  /WW2Unnxp7a/245s9ElaXqZ66omkcBNT+JYEpZtpc5e8eL1X76YKn8HJ1RP2pfouUtgXdSfi9
  +evS22FawTbmlfzrfqxbvqtM8fOr7Y+nbZxy6KVDD9V1G5Kvdl340RazynVHSf+G7fuXpQVey
  Bwp67v8umfEp3y/1/SvJ/1wjdD7kPv0cW3XsYZc4edMXMSy/h7zah30e4PTrNmtdj7XVBo0xd
  Ja53N26agesMn0tdUV/JafuQspsVzz/FPjLPk5bnN2ns/2yumXuRRX09AgbX6/YmrdizwjwuQ
  Tvo1WYmlOCPRUIu5qDgRAM/XntFhAwAA
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-8.tower-291.messagelabs.com!1587401725!315458!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5868 invoked from network); 20 Apr 2020 16:55:26 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-8.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Apr 2020 16:55:26 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 03KGsknB005425;
        Mon, 20 Apr 2020 17:55:09 +0100
Subject: Re: [PATCH] target: pr: fix PR IN, READ FULL STATUS
To:     Mike Christie <mchristi@redhat.com>, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com
References: <20200406182951.17446-1-bstroesser@ts.fujitsu.com>
 <5E8B99AC.2010303@redhat.com>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <c68c457c-7b8b-db30-f5bd-16eabb528e96@ts.fujitsu.com>
Date:   Mon, 20 Apr 2020 18:54:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <5E8B99AC.2010303@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org


On 04/06/20 23:05, Mike Christie wrote:
> 
> There is actually another isid fix needed for the core pr code:
> 
> https://patchwork.kernel.org/patch/10525287/
> 
> Handling Bart's review comment for that patch ended up being crazy
> because of other issues in the PR code so I have not completed that fix.
Sorry for coming back to this so lately.

I again had a look into your old patch. To me it seems to be clear
that apart from architectural discussion a fix is needed here.
The usage of get_unaligned_be64() is of course just wrong.

Replacing with hex2bin I think is also not ideal, because hex2bin
does not respect byte ordering of the ISID: in the protocol messages
iSCSI receives 48 bit big endian ISID. On little endian machines
hex2bin() does not do the byte swap necessary to have the same
value in string format and in u64.

BTW: I'm wondering if the double storage of ISID as u64 and as a
string should be kept. I think I'd prefer to use u64 only.
In that case lio_sess_get_initiator_sid() could just return s64
swapped to the right enianness and the isid values in session and pr
could be s64 (with -1 meaning "no ISID" in session).

BR,
Bodo

