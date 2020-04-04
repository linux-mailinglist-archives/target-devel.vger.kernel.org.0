Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6EC719E6EF
	for <lists+target-devel@lfdr.de>; Sat,  4 Apr 2020 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDDRzR (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 4 Apr 2020 13:55:17 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:54186 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726402AbgDDRzR (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1586022914; i=@ts.fujitsu.com;
        bh=mA9dXFC2HHjF/QbAFa0d8oa/VPS3ozCoqtu8eNWSYvQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=O3O8AI3dWn+tzBwiFvIdcYxT7nJRymAtU6KDduVytfndAa0gqm+er6LKsaQjgHiBM
         hcn6cSY3QqWiz7VPTtosOH7qPUok9f9zwpM8IbBEhULEcKe9HPdqacJJ63MYl0WiwA
         DT8R1APyrMmJrUrCVDrWIBcv84LF3+SgrwZIl4d+q1KOVhSRL98SX9X9ikwn8o3FWW
         HvMi6JhwW/ayLYTvVQgRUgs2s4m9OQgo+eoA2DHyoh3NC1OuLJFJmKIRThw+hN6rdx
         fR76Z+Sm9vEc/Fr2cguP1qQ1iXtCLETLfs1jQ7r1z2iPZ9nUpeObLJCFVofSQbC/6H
         zeEGKTFvrLfuQ==
Received: from [100.113.5.122] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 96/CE-32019-10AC88E5; Sat, 04 Apr 2020 17:55:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRWlGSWpSXmKPExsViZ8MxVZfxVEe
  cwbxLihZf/09nsVi5+iiTxfLj/5gs1h/ZwGjRuvQtkwOrx+6bDWweH5/eYvF4v+8qm8fm09Ue
  nzfJBbBGsWbmJeVXJLBm3PwqXHCFr2LiDaEGxuk8XYxcHEICMxklNh//wdTFyMkhLBAucX32X
  DYQW0TAVGLzyVNgNrOApcTOrm1MEA1LGSVW7H4J1sAmYCCxYtJ9li5GDg5eAUeJrWc9QUwWAR
  WJs/N5QSpEgUa+2PKHFcTmFRCUODnzCQuIzSlgJ9E1+ysTxHhbiTtzdzND2OISt57Mh4rLS2x
  /O4d5AiPfLCTts5C0zELSMgtJywJGllWM5klFmekZJbmJmTm6hgYGuoaGxrpmuhZ6iVW6SXqp
  pbrJqXklRYlAOb3E8mK94src5JwUvbzUkk2MwFBPKWTj2MF4afl7vUOMkhxMSqK8xUc64oT4k
  vJTKjMSizPii0pzUosPMcpwcChJ8O48DpQTLEpNT61Iy8wBxh1MWoKDR0mEdxdImre4IDG3OD
  MdInWKUVFKnHfTCaCEAEgiozQPrg0W65cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfOKgkz
  hycwrgZv+CmgxE9Bitrx2kMUliQgpqQamDWl9m6vuvPWVFww+Uv3T9mB81VLXG297Lb/tljmz
  rbfJ8a9Kt9yp7wqmeh2L2wRXLJ/zJjJX4x1vk079g+hLeYdTFlcUun7x/nZnQuXOjRYeiZIc4
  mcm7Wzj/rBHaTqvnGmMZLtn4hyZ45pFb2/4dC5geHpGwDhyitZp1nUJf/31nH6LPdlVmqt0p6
  PmViOr3ZSq/Lmf4jV+nFX/9SH/5ux5NwtYZwrIzlabt04tYtK2lu3ak9TrUyrKFjezhSc/m8t
  ismXK05QWy90yU2Uv/pKZJujjy1ptu8r0o8mVr9axWokZ8ornY8Xs1CcK8D+PqlHIf2Jy4+vV
  hldyH+5LSzk6v3HV6Ps/I5FtzxYlluKMREMt5qLiRAACOZincAMAAA==
X-Env-Sender: bstroesser@ts.fujitsu.com
X-Msg-Ref: server-17.tower-248.messagelabs.com!1586022913!267300!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22535 invoked from network); 4 Apr 2020 17:55:13 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-17.tower-248.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Apr 2020 17:55:13 -0000
Received: from [172.17.80.59] ([172.17.80.59])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 034HspeF022355;
        Sat, 4 Apr 2020 18:54:58 +0100
Subject: Re: [PATCH 2/2] target: make pgr_support and alua_support attributes
 writable
To:     mchristi@redhat.com, target-devel@vger.kernel.org
Cc:     ddiss@suse.de, hch@lst.de, martin.petersen@oracle.com
References: <20200403143214.18303-1-bstroesser@ts.fujitsu.com>
 <20200403143214.18303-3-bstroesser@ts.fujitsu.com>
 <ca4ab505-22f7-c46c-cbdf-7e00c5f59d0c@redhat.com>
From:   Bodo Stroesser <bstroesser@ts.fujitsu.com>
Message-ID: <c6437c47-1862-e234-8950-e675689d8c52@ts.fujitsu.com>
Date:   Sat, 4 Apr 2020 19:54:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <ca4ab505-22f7-c46c-cbdf-7e00c5f59d0c@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

Hi,

On 04/03/20 19:19, Michael Christie wrote:
> On 04/03/2020 09:32 AM, Bodo Stroesser wrote:
>>   /*
>>    * dev_attrib attributes for devices using the target core SBC/SPC
>> diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
>> index 4e37fa9b409d..e7d92ef43ca4 100644
>> --- a/drivers/target/target_core_pscsi.c
>> +++ b/drivers/target/target_core_pscsi.c
>> @@ -1073,6 +1073,7 @@ static const struct target_backend_ops pscsi_ops = {
>>   	.transport_flags_default = TRANSPORT_FLAG_PASSTHROUGH |
>>   				   TRANSPORT_FLAG_PASSTHROUGH_ALUA |
>>   				   TRANSPORT_FLAG_PASSTHROUGH_PGR,
>> +	.transport_flags_changeable = TRANSPORT_FLAG_PASSTHROUGH_PGR,
>>   	.attach_hba		= pscsi_attach_hba,
>>   	.detach_hba		= pscsi_detach_hba,
>>   	.pmode_enable_hba	= pscsi_pmode_enable_hba,
> 
> Do we need more code to support this?
> 
> For example, if LIO core is now handling PRs then it uses the I_T nexus
> info from LIO core for registrations if its not provided in the PR
> command. But port/target INQUIRY info would be from the struct
> scsi_device that pscsi is using since we pass INQUIRY down to that
> device. We will end up with mismatches where a PR-in READ_FULL_STATUS
> would return different results than the INQUIRY.
> 
You are right. There is something missing.

Would it be a good idea to check and change INQUIRY response and
maybe responses from further commands (MODE SENSE, ...) according to
in core data?

I think, such a "post processing" function for responses would be useful
for tcmu also when emulating pr in core. Otherwise userspace needs to
gather information from sys-FS and maybe additionally needs to have
per command nexus info to provide consistent responses. To me that
doesn't sound like a complete "in core pr emulation".

Btw, I think it would be helpful as a first part for ALUA also.

Thank you,
Bodo
