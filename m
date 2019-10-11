Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB39FD3D07
	for <lists+target-devel@lfdr.de>; Fri, 11 Oct 2019 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfJKKMu (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Fri, 11 Oct 2019 06:12:50 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:60614 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbfJKKMu (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1570788766; i=@ts.fujitsu.com;
        bh=nN+5/AnBjAgmytWQ+QIZ67bRYTqpCCu/McbS1UYr8H4=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=kWAnV8uNpyrzne2mjr7nx28q3EE5fcGwb21lEeMCWjBP7VFE1IThItpcoHluz6amw
         VQyU9pRcWkl4x957bYwQVGa7YMLMn5plMuS4TJ/DYBRgdiiZKmjahCRnlgJczuASpz
         MGo+SjxbBpHbNzzBJWF8WwQp6A3Gf1I60Ma6oT58b0IN7aZ3anA+Xl5FdeRxyNC0kB
         nORBPgftkZnYuAAZbOZV9zB/mqThkyxMq7hqI1sXkv9VE30B/1X76+XFFt+u+PIBbT
         CV16GBPJKcWawsNiWDmMVT3A4CpMPoP+W/ikoy3KXAfucm0aSVGTAz35y5FPVLZ0lK
         i5F2sdRJ3bk5g==
Received: from [46.226.52.103] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 47/1C-25097-E9550AD5; Fri, 11 Oct 2019 10:12:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsViZ8MxRXde6IJ
  YgwPN7BbTPvxkttizaBKTxfojGxgtWpe+ZXJg8bh8xdvj/b6rbB6bT1d7fN4kF8ASxZqZl5Rf
  kcCa8ev3ZdaCu6IV55tfsjYwHhXsYuTkEBKYxSjR2qsMYgsLOEjce3mSuYuRi0NEYA+jxO7JV
  1hAHCGBLmaJif9esIFUsQkYSKyYdJ8FxOYVcJT4c+0RK4jNIqAqcWLGaUYQW1QgXOLFlj+sED
  WCEidnPgGr5xSwltjXNI0ZxGYWsJW4M3c3lC0ucevJfCYIW15i+9s5zBMYeWchaZ+FpGUWkpZ
  ZSFoWMLKsYrRIKspMzyjJTczM0TU0MNA1NDTSNbQ0BdIGeolVuol6qaW65anFJbqGeonlxXrF
  lbnJOSl6eaklmxiBYZxScDhvB2P3kdd6hxglOZiURHkDa+fHCvEl5adUZiQWZ8QXleakFh9il
  OHgUJLgbQ9eECskWJSanlqRlpkDjCmYtAQHj5IIr1UIUJq3uCAxtzgzHSJ1ilGXY+fReYuYhV
  jy8vNSpcR55UCKBECKMkrz4EbA4vsSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHeeJApPJl
  5JXCbXgEdwQR0xBrL+SBHlCQipKQamIKWTryxXMl4trRjTEhYho3GLK/XL7k23sw90SonyCqy
  qfq2w/5KgeDS5c+LNjLWFlxM3jtxaanwj8uNNVymj35xq8zP36lupXd71v95L6ZH3Jvm2p3CM
  OnMnv5LkVeu/arav/E/a33EBDtHS90SSaVbx8uM5+bEm/5jVtv44Nn7rGO1zXJKPby3NLJXNO
  0uibwfpen72/HnbzedK6yLt/N8LNB0ez0xb9FyDrfweOnUPfxijzXO1Uw/wh/iVfa0NafFpYj
  HWs2l2W7NWfXuExZ+P+fIs0ziKn/k2mG5766vLvvkS/uXevBuZ5ByW57fmsxT78mcfHqJq+Jf
  +9KyULNzonYrn7NxKl7+MP2cEktxRqKhFnNRcSIAjddI3moDAAA=
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-16.tower-267.messagelabs.com!1570788765!303501!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11315 invoked from network); 11 Oct 2019 10:12:46 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-16.tower-267.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Oct 2019 10:12:46 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id x9BACU41027844;
        Fri, 11 Oct 2019 11:12:37 +0100
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Hannes Reinecke <hare@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <5D9EA7CA.8030306@redhat.com>
 <046448fc-a969-64a6-5782-c1cbeda8cab6@ts.fujitsu.com>
 <d286de86-beb8-e564-6308-9822c88337a0@acm.org>
 <c87f1206-4abd-d7d3-bc68-369abf80950f@ts.fujitsu.com>
 <c5c1b35f-6dcf-dedc-b380-f28b1684c69e@acm.org> <5D9FA02E.3050909@redhat.com>
 <b5c4de4c-b93d-8579-e427-79cb565e3d08@suse.de>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <38ec5155-9dd1-480a-a542-141f652bc2eb@ts.fujitsu.com>
Date:   Fri, 11 Oct 2019 12:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <b5c4de4c-b93d-8579-e427-79cb565e3d08@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org



On 10/11/19 08:09, Hannes Reinecke wrote:
> On 10/10/19 11:18 PM, Mike Christie wrote:
>> On 10/10/2019 03:14 PM, Bart Van Assche wrote:
>>> On 10/10/19 11:57 AM, Bodo Stroesser wrote:
>>>> Hmm. You are right. Ideally only SCSI-2 compliant initiators should
>>>> use the LUN field and they should run parallel SCSI only.
>>>>
>>>> OTOH, like Mike already said, we can't know whether there is any SW, FW,
>>>> BIOS, ... out there, that still sends such old style CDBs.
>>>>
>>>> For example: probably SW could send such CDBs by simply using SCSI
>>>> generic device on top of a modern initiator. (I hope that's true, I
>>>> didn't test ...)
>>>> That means, old code can produce old SCSI CDBs even when running
>>>> on top of modern HW.
>>>>
>>>> Do we want to take the risk of breaking such "old stuff"?
>>>
>>> Is blindly filtering out the LUN number correct? All initiator code that
>>
>> I have no idea about other details other than the code comments. I think
>> in general that code is wrong:
>>
>> 1. The original comment mentions iscsi and SAM2 but I think the SBC,
>> SPC, etc versions iscsi supported no longer supported commands that had
>> the LUN in those bits.
>>
>> 2. If we got one of these old commands and we clear the LUN, then we
>> have LUN=0 in that field, but the physical (not the lio level hba struct
>> but the drivers/scsi one) HBA/driver for the physical device might have
>> the physical device at LUN != 0, so I would think firmware might have
>> had issues with that.
>>
>> 3. It does not make sense to me why that list is so incomplete. I do not
>> understand why only those commands are in that list and not others.
>>
>>
> The iSCSI rfc is dated from 2004, whereas SPC-2 is dated 2001.
> And SPC-2 makes no reference to the embedded LUN.
> So one can safely assume there won't be any iSCSI devices embedding LUN
> numbers in CDBs.
> So by all intents and purposes we will only face this issue if we were
> using pscsi to talk to old SCSI-2 devices.
> 
> I'd say strip it in the general case, and delegate it to pscsi if there
> is a need.

If I understood correctly, we all would prefer to make TCMU completely
transparent regarding the CDB.

For pscsi I think we all agree, that the code is wrong or incomplete.
But for pscsi up to now no one complained. So I'm wondering whether we
should spend much effort for pscsi to discuss / find out the right
solution? Especially as the original comment in the code, as posted by
Mike, as well as the current comment are not very clear. Thus 'fixing'
pscsi would mean to change or remove something we don't understand
completely.

So I agree to Hannes: we should simply move that code from
passthrough_parse_cdb() to pscsi_parse_cdb(), at least as a first step.

Regards,
Bodo

> 
> Cheers,
> 
> Hannes
> 
