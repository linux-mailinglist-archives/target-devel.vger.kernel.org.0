Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C871A1042
	for <lists+target-devel@lfdr.de>; Tue,  7 Apr 2020 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgDGPdz (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 7 Apr 2020 11:33:55 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:34608 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729120AbgDGPdy (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1586273633; i=@ts.fujitsu.com;
        bh=/PRaNvoNE1k4Id29bk1O74R/HzVmYe9OmJXVS0PHJPY=;
        h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=LXnLIJMpemX2F4XVxIP7INL5uLZZ4/SM3rnHtY9xgGCwXVnUNIMRpXh3Z2W+a37hh
         FRBPKRuTXC9gEoK1hMNjszYEk3/Yy40GSBkIjaAnH/oEHjZ4zNDedTEleEtnVdp/HO
         Sisj6+J4VUDCVmdGZWRMgPMQgg7AW9Q2Cfksx4S72fuc/+5Ar/jvcOzpS+35rkf7Nc
         T22VjRHTx04Uo/zyrjuQo5kKpreToLMCp9c6Hxp5zFHQcIp1so+qbgVFR/OyXjPdof
         ZzoweVew28lNOODc7mAEhvj646RJDvBrGCmyEK8SiMX1JA4kv/nGPhFVp3B7rvWbW0
         rk67KDPx0sSjg==
Received: from [100.112.199.148] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id 9E/33-46636-06D9C8E5; Tue, 07 Apr 2020 15:33:52 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsViZ8MxVTdhbk+
  cwftJWhZf/09nsVi5+iiTxfLj/5gs1h/ZwGjRuvQtkwOrx+6bDWweH5/eYvF4v+8qm8fm09Ue
  nzfJBbBGsWbmJeVXJLBm3P3ZzlgwX6iib+cntgbGB3xdjFwcQgIzGSU6Hi1i72Lk5BAWCJe4P
  nsuG4jNJmAgsWLSfRYQW0TAVGLzyVNgcWYBS4mdXduYIJrvMEr8vb+XGSTBK+AoceZTKxOIzS
  KgInHnx2KwBlGgoS+2/GGFqBGUODnzCdhQTgEniW/HtrJADLWVuDN3NzOELS5x68l8JghbXmL
  72znMExj5ZiFpn4WkZRaSlllIWhYwsqxiNE8qykzPKMlNzMzRNTQw0DU0NNI1tLTUNTXXS6zS
  TdJLLdUtTy0u0TXUSywv1iuuzE3OSdHLSy3ZxAgM+ZSC45Y7GJ+ufa93iFGSg0lJlPdwdU+cE
  F9SfkplRmJxRnxRaU5q8SFGGQ4OJQlerTlAOcGi1PTUirTMHGD8waQlOHiURHi5ZgOleYsLEn
  OLM9MhUqcYFaXEeT+BJARAEhmleXBtsJi/xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY9z3
  Idp7MvBK46a+AFjMBLb6W1A2yuCQRISXVwFTG2Xjm7eYo0zUzXz3dKB34+fynZyfULrct/3TM
  2KSq1e36izlrEjxrlnHJ6OX8n8gwX26N1vYrTxbJey78n5UY0qQhtZJ9w8/zRcZOR64KyCW+7
  zOcadUR/L5X5NA0vozs9mKruhNewQtVxW/GvGVYnfDkvbWgeArndd96nkc/vyturi01UXNV80
  vZ8i3zb8rCRULHdW9O7le41cwp4frJ+43tIuYNjkUT3h/fkMHRW+i93XBfmd0O/rMFUlsj2zi
  SbYIlWs76/D366pLk7p2PFA9+/vzwCoeNgByD+YENAtPqF72TXle3qPVv8a/LPO+OCQX+/G1h
  1fbzy6O8YtXe4CVJXKp3Fk0uE0mZ3qPEUpyRaKjFXFScCAA4EMZRdAMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-30.tower-291.messagelabs.com!1586273632!1696415!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24910 invoked from network); 7 Apr 2020 15:33:52 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-30.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2020 15:33:52 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 037FXXDI013007;
        Tue, 7 Apr 2020 16:33:40 +0100
Subject: Re: [PATCH 2/2] target: make pgr_support and alua_support attributes
 writable
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
To:     mchristi@redhat.com, target-devel@vger.kernel.org
Cc:     ddiss@suse.de, hch@lst.de, martin.petersen@oracle.com
References: <20200403143214.18303-1-bstroesser@ts.fujitsu.com>
 <20200403143214.18303-3-bstroesser@ts.fujitsu.com>
 <ca4ab505-22f7-c46c-cbdf-7e00c5f59d0c@redhat.com>
 <c6437c47-1862-e234-8950-e675689d8c52@ts.fujitsu.com>
Message-ID: <c909ee07-bce3-d653-356b-e03eeadf8922@ts.fujitsu.com>
Date:   Tue, 7 Apr 2020 17:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <c6437c47-1862-e234-8950-e675689d8c52@ts.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,

On 04/04/20 19:54, Bodo Stroesser wrote:
> Hi,
> 
> On 04/03/20 19:19, Michael Christie wrote:
>> On 04/03/2020 09:32 AM, Bodo Stroesser wrote:
>>>   /*
>>>    * dev_attrib attributes for devices using the target core SBC/SPC
>>> diff --git a/drivers/target/target_core_pscsi.c 
>>> b/drivers/target/target_core_pscsi.c
>>> index 4e37fa9b409d..e7d92ef43ca4 100644
>>> --- a/drivers/target/target_core_pscsi.c
>>> +++ b/drivers/target/target_core_pscsi.c
>>> @@ -1073,6 +1073,7 @@ static const struct target_backend_ops 
>>> pscsi_ops = {
>>>       .transport_flags_default = TRANSPORT_FLAG_PASSTHROUGH |
>>>                      TRANSPORT_FLAG_PASSTHROUGH_ALUA |
>>>                      TRANSPORT_FLAG_PASSTHROUGH_PGR,
>>> +    .transport_flags_changeable = TRANSPORT_FLAG_PASSTHROUGH_PGR,
>>>       .attach_hba        = pscsi_attach_hba,
>>>       .detach_hba        = pscsi_detach_hba,
>>>       .pmode_enable_hba    = pscsi_pmode_enable_hba,
>>
>> Do we need more code to support this?
>>
>> For example, if LIO core is now handling PRs then it uses the I_T nexus
>> info from LIO core for registrations if its not provided in the PR
>> command. But port/target INQUIRY info would be from the struct
>> scsi_device that pscsi is using since we pass INQUIRY down to that
>> device. We will end up with mismatches where a PR-in READ_FULL_STATUS
>> would return different results than the INQUIRY.
>>
> You are right. There is something missing.
> 
> Would it be a good idea to check and change INQUIRY response and
> maybe responses from further commands (MODE SENSE, ...) according to
> in core data?
> 
> I think, such a "post processing" function for responses would be useful
> for tcmu also when emulating pr in core. Otherwise userspace needs to
> gather information from sys-FS and maybe additionally needs to have
> per command nexus info to provide consistent responses. To me that
> doesn't sound like a complete "in core pr emulation".
> 
> Btw, I think it would be helpful as a first part for ALUA also.
> 
> Thank you,
> Bodo

Such kind of "post processing" looks like a bigger effort.
Would you agree if I resend the patch without the hunk that makes
TRANSPORT_FLAG_PASSTHROUGH_PGR changeable for pscsi?

Then the new code can be implemented later and the changeable flag
for pscsi might be acceptable after that.
