Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7124C243C
	for <lists+target-devel@lfdr.de>; Thu, 24 Feb 2022 07:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiBXGyO (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Thu, 24 Feb 2022 01:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiBXGyN (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:54:13 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED58194AA1;
        Wed, 23 Feb 2022 22:53:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E222168AA6; Thu, 24 Feb 2022 07:53:41 +0100 (CET)
Date:   Thu, 24 Feb 2022 07:53:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 5/8] scsi: remove the sense and sense_len fields from
 struct scsi_request
Message-ID: <20220224065341.GB20737@lst.de>
References: <20220222140443.589882-1-hch@lst.de> <20220222140443.589882-6-hch@lst.de> <424d74d5-3150-78d7-20de-40d1a16a495d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424d74d5-3150-78d7-20de-40d1a16a495d@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On Wed, Feb 23, 2022 at 03:39:58PM -0800, Bart Van Assche wrote:
> On 2/22/22 06:04, Christoph Hellwig wrote:
>> @@ -613,10 +614,10 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
>>     	err = req->result & 0xff;	/* only 8 bit SCSI status */
>>   	if (err) {
>> -		if (req->sense_len && req->sense) {
>> -			bytes = (OMAX_SB_LEN > req->sense_len) ?
>> -				req->sense_len : OMAX_SB_LEN;
>> -			if (copy_to_user(sic->data, req->sense, bytes))
>> +		if (scmd->sense_len && scmd->sense_buffer) {
>> +			bytes = (OMAX_SB_LEN > scmd->sense_len) ?
>> +				scmd->sense_len : OMAX_SB_LEN;
>> +			if (copy_to_user(sic->data, scmd->sense_buffer, bytes))
>>   				err = -EFAULT;
>>   		}
>>   	} else {
>
> This change would be a good opportunity to remove the two superfluous 
> parentheses from the above code.

Or switch to use the min or min_t macro, yes.

>
>> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
>> index 3e432e25645ac..47add5b32f460 100644
>> --- a/include/scsi/scsi_cmnd.h
>> +++ b/include/scsi/scsi_cmnd.h
>> @@ -112,6 +112,7 @@ struct scsi_cmnd {
>>   				   reconnects.   Probably == sector
>>   				   size */
>>   +	unsigned sense_len;
>>   	unsigned char *sense_buffer;
>>   				/* obtained by REQUEST SENSE when
>>   				 * CHECK CONDITION is received on original
>
> Isn't "unsigned int" preferred over "unsigned" in new code?

checkpatch states that, but for absolutely no reason.
