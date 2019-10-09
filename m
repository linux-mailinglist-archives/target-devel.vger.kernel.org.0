Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF6CD0E4E
	for <lists+target-devel@lfdr.de>; Wed,  9 Oct 2019 14:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfJIMGo (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Wed, 9 Oct 2019 08:06:44 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:59820 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727286AbfJIMGo (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1570622801; i=@ts.fujitsu.com;
        bh=VCEuhNHS0AW0V23+jSevisrhnIyKtXfM1NhQJTF2giE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=ImcVj3K4qQtf6RBToej4EVTk2HF/3qBI2hXAkLrBCHw1nD0xYy0G4WsavEE14qMrM
         4hcercYW3bY7nsHzt1jCQhd1tcBx/htjfk1Tc4QYiCT4X0diTsPN+Mbl7TanDRagSg
         HH+vyUgDSwgcbENZwIyek9g/w8LrKHvD49o90qIi9+uC4P0KkxpUC4gR8qjgsxoDFM
         OvpZ474QeislLT27FscuxNGACFMRIJVh9JI0hbosJ/+rzHiVpev6keD3/phtCjsPKe
         v7e/fiapqkh4zWmikljf0PkEfrCgi5zgatntPMOEc6NwLG3WVrl1+hq2FwlpUNOm0K
         COx9ZlKKgrcqg==
Received: from [46.226.52.103] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 94/D1-26280-05DCD9D5; Wed, 09 Oct 2019 12:06:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRWlGSWpSXmKPExsViZ8MRqhtwdm6
  swa6ZchanJyxislh/ZAOjRevSt0wOzB6bV2h5vN93lc3j8ya5AOYo1sy8pPyKBNaM0ztnMhds
  56pYOuMHUwPjTI4uRi4OIYGZjBLfX61h6WLk5BAWcJC49/IkM4gtIlAssXdVPyNIEbNAG6PEj
  pN/2EASQgLlEtMfXgMrYhMwkFgx6T5YM6+Ao8SrU1tZQWwWARWJBxumg9WICoRLvNjyhxWiRl
  Di5MwnYPWcAsYSn+/vYQexmQXMJOZtfsgMYYtL3HoynwnClpfY/nYO8wRGvllI2mchaZmFpGU
  WkpYFjCyrGM2TijLTM0pyEzNzdA0NDHQNDY10DS2NdU0t9RKrdBP1Ukt1y1OLS3QN9RLLi/WK
  K3OTc1L08lJLNjECQzml4KD1DsaXM9/oHWKU5GBSEuX1XjI3VogvKT+lMiOxOCO+qDQntfgQo
  wwHh5IEr/tpoJxgUWp6akVaZg4wrmDSEhw8SiK8J04BpXmLCxJzizPTIVKnGHU5dh6dt4hZiC
  UvPy9VSpx3P0iRAEhRRmke3AhYjF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMz7C2QKT2Z
  eCdymV0BHMAEdke8yG+SIkkSElFQDk/pVE8U/77h+fXjbm7FnQoAiv79Ou/iJW7ln2Iz/qaZs
  kWNnqtARlp9xSKQ8ZtcOqWWHD1V4sKm+FJu004N1p8PvuWafF5011rrPdkbicZfi+V2cvmLZC
  lcSl1Sv8NO8FGKgZ5DyZ2Ya31y/V72WT1yW2u9zPTK1a7qsRETpgedzK97+Kn5/56v5LfG8Ms
  OFD23/vVWP2KdprVG/YQ+zSuLDrUohybYZi8+HmZw/rGI54zXjf61C/qdVbOv1jr/yzo6uepJ
  o6cWYVeqw0PnN173rfIq3fNyZsmTuJrN1u/e9ap+l/VXq1d6cqWuydqXs1dTOSr3q/ePJMo7j
  xy8n+YdeYOM+LJuXpK/A8SC4WYmlOCPRUIu5qDgRADYAqsBsAwAA
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-24.tower-267.messagelabs.com!1570622800!57512!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5448 invoked from network); 9 Oct 2019 12:06:40 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-24.tower-267.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 9 Oct 2019 12:06:40 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id x99C6Pjp026788;
        Wed, 9 Oct 2019 13:06:26 +0100
Subject: Re: Wrong resetting of Logical Unit Number field in CDB
To:     Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?B?U3Ryw7Zzc2VyLCBCb2Rv?= <bodo.stroesser@ts.fujitsu.com>
Cc:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Mike Christie (mchristi@redhat.com)" <mchristi@redhat.com>
References: <ac680e032540400a8cd7b1bf03361df3@R01UKEXCASM125.r01.fujitsu.local>
 <20191009070007.GA19629@infradead.org>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <edf61b13-06e0-85ac-3d79-bb91e10cef96@ts.fujitsu.com>
Date:   Wed, 9 Oct 2019 14:06:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20191009070007.GA19629@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 10/09/19 09:00, Christoph Hellwig wrote:
> On Tue, Oct 08, 2019 at 08:20:12PM +0000, bodo.stroesser@ts.fujitsu.com wrote:
>> 1) Scan the SCSI specs and add all other missing command codes to the list of
>>     Codes to skip
>>
>> 2) Create a list of commands that definitely have the LUN field in byte 1 and
>>     reset the bits only in those. (Might be better than 1), because I expect new
>>     commands to not have the LUN field.)
>>
>> 3) Remove the code entirely, because it is no longer needed / useful (?)
>>
>> For 1) and 2) an additionally question is, based on what SCSI version the lists would
>> have to be created?
> 
> (4) limit the clearing of the LUN field to devices that claim
> a compliance to SCSI-2 or earlier, as those use the LUN field.
> 
I'm not sure that (4) would work.
The comment in the code says:

   /*
    * Clear a lun set in the cdb if the initiator talking to use spoke
    * and old standards version, as we can't assume the underlying device
    * won't choke up on it.
    */

If I understand correctly, the purpose of the code is just the opposite 
from what you suggest, as it should reset useless LUN bits coming from
old (SCSI-2) initiators, that otherwise could confuse SCSI-3 or higher 
targets.
SCSI-2 compliant targets should not run into trouble due to LUN bits 
being set, I think.
